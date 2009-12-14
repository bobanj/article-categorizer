#This rake task gets articles from www.a1.com.mk and stores them in database
namespace :a1 do
  desc "Fill database with articles from a1.com.mk"
  task :get_articles => :environment do
    a1 = Media::A1.new(ENV['start'],ENV['count'])
    a1.get_articles
  end
end