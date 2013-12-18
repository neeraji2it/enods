class CreateShippingProducts < ActiveRecord::Migration
  def change
    create_table :shipping_products do |t|
      t.integer :product_id
      t.string :country
      t.string :cost
      t.string :location
      t.string :item_cost
      t.timestamps
    end
  end
end
