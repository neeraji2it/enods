class AddPendingValues < ActiveRecord::Migration
  def up
    add_column :colors, :size, :string
    add_column :causes, :description, :text
    add_column :orders, :color, :string
    add_column :orders, :buyer_type, :string
    add_column :orders, :size, :string
    add_column :colors, :buyer_type, :string
    add_column :orders, :cause, :string
    add_column :line_items, :user_id, :integer
  end

  def down
    remove_column :colors, :size
    remove_column :causes, :description
    remove_column :orders, :color
    remove_column :orders, :buyer_type
    remove_column :orders, :size
    remove_column :colors, :buyer_type
    remove_column :orders, :cause
    remove_column :line_items, :user_id
  end
end
