class Color < ActiveRecord::Base
  attr_accessible :product_color,:product_id, :product_qty
  validates :product_color, :product_qty, :presence => true
  belongs_to :product
end
