class Favourite < ActiveRecord::Base
  attr_accessible :user_id, :product_id, :status
  belongs_to :user
  belongs_to :product
end
