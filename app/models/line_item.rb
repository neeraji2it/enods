class LineItem < ActiveRecord::Base
  attr_accessible :cart_id, :product_id, :quantity, :unit_price, :user_id
  belongs_to :cart
  belongs_to :product
  has_many :orders, :dependent => :destroy
  
  def full_price
    unit_price * quantity
  end
end
