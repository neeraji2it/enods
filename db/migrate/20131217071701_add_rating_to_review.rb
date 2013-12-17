class AddRatingToReview < ActiveRecord::Migration
  def change
    add_column :reviews, :rating, :string
  end
end
