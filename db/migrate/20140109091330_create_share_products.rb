class CreateShareProducts < ActiveRecord::Migration
  def change
    create_table :share_products do |t|
      t.integer :product_id
      t.string :provider
      t.string :uid
      t.string :token
      t.string :secret
      t.text :details
      t.timestamps
    end
  end
end
