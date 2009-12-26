#This rake task Trains all Categories
# USE THIS ONLY IF ALL YOUR ARTICLES ARE 'UNTRAINED'
namespace :media do
  desc "Categorizing Trainer"
  task :train_all => :environment do
    Categorizer::Bayes.class
    ObjectStash.store Categorizer::Bayes.new([]), CATEGORIZER_PATH
    categories = Category.find(:all, :conditions => "name != ''")
    #categotizer = ObjectStash.load CATEGORIZER_PATH
    categories.each{|category|
      num_pages = category.articles.paginate(:per_page => 50, :page => 1).total_pages
      (1..num_pages).each{ |page|
        articles = category.articles.paginate(:per_page => 50, :page => page)
        articles.each{ |article|
          categotizer.train(category.name, article.body)
        }
      }
    }
    ObjectStash.store categotizer, CATEGORIZER_PATH
  end
end





