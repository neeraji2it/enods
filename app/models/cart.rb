class Cart < ActiveRecord::Base
  has_many :line_items, :dependent => :destroy
  has_many :orders, :dependent => :destroy

  attr_accessible :purchased_at, :created_at, :product_id

  has_one :order, :dependent => :destroy

  def add_item(product_id, quantity)
    current_item = line_items.where(:product_id => product_id).first
    if current_item
      current_item.quantity += quantity
    else
      current_item = LineItem.new(product_id: product_id, quantity: quantity)
      line_items << current_item
    end
    current_item
  end
end
