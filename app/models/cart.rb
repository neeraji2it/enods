class Cart < ActiveRecord::Base
  has_many :line_items, :dependent => :destroy
  has_many :orders, :dependent => :destroy

  attr_accessible :purchased_at, :created_at, :product_id, :ip_address

  has_one :order, :dependent => :destroy

  def add_item(product_id, quantity)
    current_item = line_items.find_by_product_id(product_id)
    if current_item
      current_item.quantity += quantity
    else
      current_item = line_items.build(product_id: product_id, quantity: quantity)
    end
    current_item
  end
end
