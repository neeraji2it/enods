class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :user_id
      t.integer :category_id
      t.string :title
      t.text :description
      t.string :price
      t.integer :product_count, :default => 0
      t.string :status

      t.timestamps
    end
  end
end
