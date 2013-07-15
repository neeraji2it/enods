class AddPaypalIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :paypal_id,:string
    add_column :users, :date_of_birth, :datetime
    add_column :users, :other_info, :text
  end
end
