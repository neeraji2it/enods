class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.datetime :purchased_at
      t.integer :product_id
      t.string :paypal_express_token
      t.timestamps
    end
  end
end
