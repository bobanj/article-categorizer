class Portal < ActiveRecord::Base
  attr_accessible :name, :hostname
  has_many :categories
  has_many :articles, :through => :categories
end
