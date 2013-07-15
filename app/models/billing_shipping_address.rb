class BillingShippingAddress < ActiveRecord::Base
  attr_accessible :product_id,:user_id,:order_id,:billling_house_no,:shipping_house_no,:billing_street,:shipping_street,:billing_city,:shipping_city,:billing_zip,:shipping_zip,:billing_country,:shipping_country
  validates :product_id,:billling_house_no,:shipping_house_no,:billing_street,:shipping_street,:billing_city,:shipping_city,:billing_zip,:shipping_zip,:billing_country,:shipping_country, :presence => true
  belongs_to :user
  belongs_to :order
  belongs_to :product
end
