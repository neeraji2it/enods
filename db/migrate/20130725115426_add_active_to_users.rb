class AddActiveToUsers < ActiveRecord::Migration
  def change
    add_column :users, :active, :string
  end
end
