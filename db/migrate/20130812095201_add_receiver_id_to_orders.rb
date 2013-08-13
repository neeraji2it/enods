class AddReceiverIdToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :receiver_id, :integer
  end
end
