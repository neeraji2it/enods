class AddRejectMessageToProducts < ActiveRecord::Migration
  def change
    add_column :products, :reject_message, :text
  end
end
