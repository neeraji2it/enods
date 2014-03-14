class AddIpAddressToCarts < ActiveRecord::Migration
  def change
    add_column :carts, :ip_address, :string
  end
end
