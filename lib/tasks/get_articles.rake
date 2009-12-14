#This rake task gets articles from www.a1.com.mk and stores them in database
namespace :media do
  desc "Fill database with articles from a1.com.mk"
  task :get_articles => :environment do
    media = Media.new("a1",ENV['start'],ENV['count'])
    media.get_articles
  end
end