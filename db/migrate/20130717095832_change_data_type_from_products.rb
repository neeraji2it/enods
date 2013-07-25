class ChangeDataTypeFromProducts < ActiveRecord::Migration
  def up
    change_column :products, :qty, :decimal, :default => 0
    change_column :products, :qty_sold, :decimal, :default => 0
  end

  def down
    change_column :products, :qty, :integer
    change_column :products, :qty_sold, :integer
  end
end
