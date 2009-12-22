#if start and count params are provided parsing is done from the provided
#startid, and if count is the number of articles to parse
class Media
  def initialize(name, start, count)
    @portal = Portal.find_by_name(name)
    @http = Net::HTTP.new(@portal.hostname)
    @first_article_id = get_first_article_id(start)
    @max_article_id = get_max_article_id
    @last_article_id = get_last_article_id(count)
  end

  #Gets all requested articles from www.a1.com.mk
  def get_articles(options = {:train => false})
    puts "FIRST ARTICLE ID #{@first_article_id}"
    puts "LAST ARTICLE ID #{@last_article_id}"
    puts "INITIALIZING CATEGORIZER"
    Categorizer::Bayes.class
    categorizer = ObjectStash.load CATEGORIZER_PATH if options[:train] == true
    puts "CATEGORIZER INITIALIZED"
    (@first_article_id..@last_article_id).each do |article_id|
      response, doc = @http.get("/vesti/default.aspx?VestID=#{article_id}")
      if response.code == "200"
        doc = Nokogiri::HTML(doc, nil, 'WINDOWS-1251')
        category_name = doc.at('a#lnkKat').text.strip
        category = @portal.categories.find_or_create_by_name(:name => category_name)
        title = doc.at('#H2naslov').text
        body = title + doc.css('td p').collect(&:text).join
        article = category.articles.create(:title => title, :body => body, :itemid => article_id.to_s)
        if options[:train] == true && article.errors.size == 0
          categorizer.train(category.name, article.body)
        end
        puts "Article #{article_id}"
      end
    end
    puts "SAVING CATEGORIZER"
    ObjectStash.store categorizer, CATEGORIZER_PATH
    puts "CATEGORIZER SAVED"
  end

  #Private functions go here
  private
  def get_first_article_id(start)
    if start.blank?
      @first_article_id = @portal.articles.last.itemid.to_i rescue 50
    else
      @first_article_id = (start.to_i > 50 ? start.to_i : 50)
    end
  end

  def get_last_article_id(count)
    if count.blank?
      @max_article_id
    else
      ((@first_article_id + count.to_i) > @max_article_id ? @max_article_id : (@first_article_id + count.to_i))
    end
  end

  def get_max_article_id
    response, doc = @http.get("/default.aspx")
    if response.code == "200"
      doc = Nokogiri::HTML(doc, nil, 'WINDOWS-1251')
      doc.at('h2>a.Vesti')[:href].match(/[0-9]+/).to_s.to_i rescue 0
    else
      puts "#------ RESPONSE CODE FOR /default.aspx FAIL ------#"
      return 0
    end
  end
end