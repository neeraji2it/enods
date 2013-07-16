class AddColorToProducts < ActiveRecord::Migration
  def change
    add_column :products, :qty, :integer
    add_column :products, :color, :string
    add_column :products, :qty_sold, :integer
    add_column :products, :product_id, :string
    add_column :orders, :paykey, :string
    add_column :orders, :details, :text
    add_column :orders, :status, :string
    add_column :orders, :net_payment, :string
    add_column :orders, :admin_payment, :string
    add_column :orders, :non_profit_payment, :string
    add_column :orders, :cancel_date, :datetime
    add_column :orders, :payment_type, :string
    add_column :orders, :confirm_date, :datetime
    add_column :orders, :product_id, :integer
    add_column :carts, :product_id, :integer
    remove_column :orders, :express_token
    remove_column :orders, :card_expires_on
    remove_column :orders, :ip_address
    remove_column :orders, :first_name
    remove_column :orders, :last_name
    remove_column :orders, :express_payer_id
  end
end
