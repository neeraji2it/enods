class LineItem < ActiveRecord::Base
  attr_accessible :cart_id, :product_id, :quantity, :unit_price
  belongs_to :cart
  belongs_to :product

  def full_price
    unit_price * quantity
  end
end
