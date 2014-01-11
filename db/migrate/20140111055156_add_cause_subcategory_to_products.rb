class AddCauseSubcategoryToProducts < ActiveRecord::Migration
  def change
    add_column :products, :cause_sub_category, :string
  end
end
