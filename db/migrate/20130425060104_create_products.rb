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
      t.decimal :qty, :default => 0
      t.string :color
      t.decimal :qty_sold, :default => 0
      t.string :non_profit_email
      t.string :fair_trade
      t.integer :cause_id

      t.timestamps
    end
  end
end
