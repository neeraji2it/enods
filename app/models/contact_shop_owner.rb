class ContactShopOwner < ActiveRecord::Base
  attr_accessible :subject, :message, :user_id, :receiver_id, :attach
  validates :subject, :message, :presence => true
  belongs_to :user, :class_name => 'User'
  belongs_to :receiver, :class_name => 'User'
  has_attached_file :attach, :styles => {:thumb => '90*90>', :large => '900*900>'}, :default_url => "/assets/img-seller-infomation.jpg" if Rails.env == 'development'
  has_attached_file :attach,:whiny => false,:storage => :s3,:s3_credentials => "#{Rails.root}/config/s3.yml",:path => "uploaded_files/profile/:id/:style/:basename.:extension",:bucket => "enods-web",:styles => {:original => "900x900>",:default => "280x190>",:other => "96x96>"}, :default_url => "/assets/img-seller-infomation.jpg" if Rails.env == 'production'
end
