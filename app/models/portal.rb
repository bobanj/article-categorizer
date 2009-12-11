class Portal < ActiveRecord::Base
  attr_accessible :name, :hostname
  has_many :categories
end
