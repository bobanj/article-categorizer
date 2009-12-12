class Article < ActiveRecord::Base
  attr_accessible :category, :title, :body, :itemid
  belongs_to :category
  validates_uniqueness_of :itemid
end
