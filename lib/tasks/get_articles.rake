#This rake task gets articles from www.a1.com.mk and stores them in database
namespace :a1 do
  desc "Fill database with articles from a1.com.mk"
  task :get_articles => :environment do

    portal = Portal.find_by_name "a1"
    http = Net::HTTP.new(portal.hostname)

    response, doc = http.get("/default.aspx")
    if response.code == "200"
      doc = Nokogiri::HTML(doc, nil, 'WINDOWS-1251')
      first_article_id = portal.articles.last.itemid.to_i
      first_article_id = 50 if first_article_id == 0
      last_article_id = doc.at('h2>a.Vesti')[:href].match(/[0-9]+/).to_s.to_i rescue 0
      puts "FIRST ARTICLE ID #{first_article_id}"
      puts "LAST ARTICLE ID #{last_article_id}"
      if last_article_id > 0
        (first_article_id..last_article_id).each do |article_id|
          puts "ARTICLE #{article_id}"
          response, doc = http.get("/vesti/default.aspx?VestID=#{article_id}")
          if response.code == "200"
            doc = Nokogiri::HTML(doc, nil, 'WINDOWS-1251')
            category_name = doc.at('a#lnkKat').text.strip
            category = portal.categories.find_or_create_by_name :name => category_name
            title = doc.at('#H2naslov').text
            body = title + doc.css('td p').collect(&:text).join
            category.articles.create :title => title, :body => body, :itemid => article_id.to_s
          end
        end
      else
        puts "#------ CHECK PARSING LAST ARTICLE ID ------#"
      end
    else
      puts "#------ RESPONSE CODE FOR /default.aspx FAIL ------#"
    end
  end
end