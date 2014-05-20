class CreatePromotionCodes < ActiveRecord::Migration
  def change
    create_table :promotion_codes do |t|
      t.string :promo_code
      t.decimal :price
      t.timestamps
    end
  end
end
