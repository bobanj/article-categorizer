Portal.delete_all
Portal.create :name => "a1", :hostname => "a1.com.mk"
ObjectStash.store  Categorizer::Bayes.new([]), CATEGORIZER_PATH