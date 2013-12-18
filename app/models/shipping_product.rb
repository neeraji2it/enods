class ShippingProduct < ActiveRecord::Base
  attr_accessible :cost,:country,:product_id, :location,:item_cost
  validates :cost,:country,:item_cost, :presence => true
  belongs_to :product
end
