class CreateColors < ActiveRecord::Migration
  def change
    create_table :colors do |t|
      t.integer :product_id
      t.string :product_color
      t.integer :product_qty, :default => 0
      t.timestamps
    end
  end
end
