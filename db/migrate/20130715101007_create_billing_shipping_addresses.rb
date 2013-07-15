class CreateBillingShippingAddresses < ActiveRecord::Migration
  def change
    create_table :billing_shipping_addresses do |t|
      t.integer :product_id
      t.integer :user_id
      t.integer :order_id
      t.string :billling_house_no
      t.string :shipping_house_no
      t.string :billing_street
      t.string :shipping_street
      t.string :billing_city
      t.string :shipping_city
      t.string :billing_zip
      t.string :shipping_zip
      t.string :billing_country
      t.string :shipping_country

      t.timestamps
    end
  end
end
