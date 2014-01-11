class AddAttributeToColors < ActiveRecord::Migration
  def change
    add_column :colors, :product_attribute, :string
  end
end
