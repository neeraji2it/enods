class Category < ActiveRecord::Base
  attr_accessible :name
  has_many :products, :dependent => :destroy
  validates :name, :uniqueness => true, :presence => true
end
