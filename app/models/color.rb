class Color < ActiveRecord::Base
  attr_accessible :product_color,:product_id, :product_attribute, :size, :buyer_type
  validates :product_color, :presence => true
  belongs_to :product
end
