require 'rubygems'
require 'nokogiri'
require 'net/http'

SITE = 'www.a1.com.mk'

categories = []
http = Net::HTTP.new(SITE)

#response.each{|k,v| puts "#{k} => #{v}"}
#encoding = response["content-type"].match(/charset=(\S+)/)
(50..1000).each do |num|
  response, doc = http.get("/vesti/default.aspx?VestID=#{num}")
  if response.code == "200"
    doc = Nokogiri::HTML(doc, nil, 'WINDOWS-1251')
    category = doc.css('a#lnkKat')[0].content
    categories << category unless categories.include? category
  end
end
p categories