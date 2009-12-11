class Category < ActiveRecord::Base
  attr_accessible :name, :portal
  belongs_to :portal
  has_many :articles
end
