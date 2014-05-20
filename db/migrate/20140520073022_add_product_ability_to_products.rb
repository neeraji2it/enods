class AddProductAbilityToProducts < ActiveRecord::Migration
  def change
    add_column :products, :product_ability, :boolean
    add_column :products, :promotion_code_id, :integer
  end
end
