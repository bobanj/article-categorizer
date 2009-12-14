#This rake task Trains all Categories
namespace :media do
  desc "Categorizing Trainer"
  task :train => :environment do
    categories = Category.find(:all, :conditions => "name != ''")
    classifier = Categorizer::Bayes.new(categories.collect(&:name))
    categories.each{|category|
      category.articles.find(:all, :limit => 100).each { |article|
        classifier.train(category.name, article.body)
      }
    }
  end
end





