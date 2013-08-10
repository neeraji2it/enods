class CreateCauses < ActiveRecord::Migration
  def change
    create_table :causes do |t|
      t.string :title
      t.integer :product_id
      t.string   :image_file_name
      t.string   :image_content_type
      t.integer  :image_file_size
      t.timestamps
    end
  end
end
