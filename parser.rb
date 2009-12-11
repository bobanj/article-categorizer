require 'rubygems'
require 'nokogiri'
require 'net/http'

SITE = 'www.a1.com.mk'
$KCODE='UTF8'
categories = []
http = Net::HTTP.new(SITE)

response, doc = http.get("/default.aspx")
if response.code == "200"
  doc = Nokogiri::HTML(doc, nil, 'WINDOWS-1251')
  last_article_id = doc.at('h2>a.Vesti')[:href].match(/[0-9]+/).to_s.to_i
  if last_article_id.to_i > 0
    (last_article_id..last_article_id).each do |article_id|
      response, doc = http.get("/vesti/default.aspx?VestID=#{article_id}")
      if response.code == "200"
        doc = Nokogiri::HTML(doc, nil, 'WINDOWS-1251')
        #category_name = doc.at('a#lnkKat').text.strip
        #puts category_name
        title = doc.at('#H2naslov').text
        text = title + doc.css('td p').collect(&:text).join
          puts text
          puts "##############"
      end
    end

  end
else
  puts "#------ CHECK PARSING LAST ARTICLE ID ------#"
end


#response.each{|k,v| puts "#{k} => #{v}"}
#encoding = response["content-type"].match(/charset=(\S+)/)
#(100..100).each  do |num|
#  response, doc = http.get("/vesti/default.aspx?VestID=#{num}")
#  if response.code == "200"
#    doc = Nokogiri::HTML(doc, nil, 'WINDOWS-1251')
#    category_name =  doc.at('a#lnkKat').text.strip
#    category = Category.find_by_name_or_create(:name => category_name)
#categories << category unless categories.include? category
#doc.css('td p , p b, #H2naslov').reverse_each do |part, i|
#end
#  end
#end
