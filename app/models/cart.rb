class Cart < ActiveRecord::Base
  has_many :line_items, :dependent => :destroy
  has_many :orders, :dependent => :destroy

  attr_accessible :user_id, :purchased_at, :created_at, :product_id

  has_one :order, :dependent => :destroy

  def add_item(product_id)
    current_item = line_items.where(:product_id => product_id).first
    if current_item
      current_item.quantity += 1
    else
      current_item = LineItem.new(product_id: product_id, quantity: 1)
      line_items << current_item
    end
    current_item
  end

  def total_price
    line_items.to_a.sum {|item| item.unit_price}
  end

  def total_price_in_cents
    (self.total_price*100).round
  end

  def paypal_description
    store_names = []
    for user_deal in line_items
      store_names << user_deal.product.title
    end
    return !store_names.empty? ? "Store credit at #{store_names.join(', ')} and total price $#{self.total_price}" : ""
  end
end
