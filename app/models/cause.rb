class Cause < ActiveRecord::Base
  belongs_to :product
  attr_accessible :title, :product_id, :image
  validates :title, :presence => true
  has_attached_file :image, :styles => {:original => "900x900>",:default => "226x287!",:thumb => "96x96>"}
  validates_attachment_content_type :image,
    :content_type => [ 'image/jpeg','image/jpg', 'image/png', 'image/gif','image/bmp', 'image/x-png', 'image/pjpeg' ]
  validates_attachment_presence :image
end
