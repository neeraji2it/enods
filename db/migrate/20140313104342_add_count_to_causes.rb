class AddCountToCauses < ActiveRecord::Migration
  def change
    add_column :causes, :count, :integer, :default => 0
  end
end
