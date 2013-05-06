class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :cart_id
      t.integer :user_id
      t.string :ip_address
      t.string :first_name
      t.string :last_name
      t.string :card_type
      t.string :express_token
      t.string :express_payer_id
      t.date :card_expires_on
      t.datetime :created_at
      t.timestamps
    end
  end
end
