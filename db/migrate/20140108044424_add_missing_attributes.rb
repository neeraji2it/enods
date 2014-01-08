class AddMissingAttributes < ActiveRecord::Migration
  def up
    add_column :products, :sell_name, :string
    add_column :products, :shipping, :text
    add_column :products, :terms_and_conditions, :text
  end

  def down
    remove_column :products, :sell_name
    remove_column :products, :shipping
    remove_column :products, :terms_and_conditions
  end
end
