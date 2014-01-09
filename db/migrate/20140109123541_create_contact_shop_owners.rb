class CreateContactShopOwners < ActiveRecord::Migration
  def change
    create_table :contact_shop_owners do |t|
      t.integer :user_id
      t.integer :receiver_id
      t.string :subject
      t.text :message
      t.string :attach_file_name
      t.string :attach_content_type
      t.integer :attach_file_size
      t.timestamps
    end
  end
end
