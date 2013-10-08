class AddImageDescriptionToBannerImages < ActiveRecord::Migration
  def change
    add_column :banner_images, :image_description, :text
  end
end
