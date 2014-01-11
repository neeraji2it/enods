class Color < ActiveRecord::Base
  attr_accessible :product_color,:product_id, :product_attribute
  validates :product_color, :product_attribute, :presence => true
  belongs_to :product
end
