class AddColorsToProducts < ActiveRecord::Migration
  def change
    add_column :products, :discount, :integer
  end
end
