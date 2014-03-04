class AddStoreImageToUsers < ActiveRecord::Migration
  def change
    add_column :users, :store_image_file_name, :string
    add_column :users, :store_image_content_type, :string
    add_column :users, :store_image_file_size, :integer
  end
end
