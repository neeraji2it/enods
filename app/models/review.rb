class Review < ActiveRecord::Base
  attr_accessible :title, :name, :message, :product_id, :user_id, :rating
  validates :title, :name, :message, :presence => true
  belongs_to :product
end
