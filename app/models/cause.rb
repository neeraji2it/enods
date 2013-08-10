class Cause < ActiveRecord::Base
  belongs_to :product
  attr_accessible :title, :product_id, :image
  has_attached_file :image, :style => {:thumb => "90*90>", :large => "900*900>"} if Rails.env == 'development'
  has_attached_file :image,:whiny => false,:storage => :s3,:s3_credentials => "#{Rails.root}/config/s3.yml",:path => "uploaded_files/profile/:id/:style/:basename.:extension",:bucket => "enods-web",:styles => {:original => "900x900>",:default => "280x190>",:other => "96x96>"} if Rails.env == 'production'
end
