class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.integer :product_id
      t.string :name
      t.text :message
      t.string :title
      t.timestamps
    end
  end
end
