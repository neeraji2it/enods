class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :cart_id
      t.integer :user_id
      t.string :paykey
      t.text :details
      t.string :status
      t.string :net_payment
      t.string :admin_payment
      t.string :non_profit_payment
      t.datetime :cancel_date
      t.string :payment_type
      t.datetime :confirm_date
      t.integer :product_id
      t.integer :line_item_id
      t.integer :receiver_id
      t.timestamps
    end
  end
end
