class PromotionCode < ActiveRecord::Base
  attr_accessible :promo_code, :price
  validates :promo_code,:price, :presence => true
end
