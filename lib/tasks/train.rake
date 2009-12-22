#This rake task Trains all Categories
# USE THIS ONLY IF ALL YOUR ARTICLES ARE 'UNTRAINED'
namespace :media do
  desc "Categorizing Trainer"
  task :train_all => :environment do
    categories = Category.find(:all, :conditions => "name != ''")
    #categotizer = Categorizer::Bayes.new(categories.collect(&:name))
    Categorizer::Bayes.class
    categotizer = ObjectStash.load CATEGORIZER_PATH
    categories.each{|category|
      category.articles.find(:all).each { |article|
        categotizer.train(category.name, article.body)
      }
    }
    ObjectStash.store categotizer, CATEGORIZER_PATH
  end
end





