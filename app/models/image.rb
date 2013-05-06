class Image < ActiveRecord::Base
  attr_accessible :image,:product_id
  belongs_to :product
  has_attached_file :image, :style => {:thumb => "90*90>", :large => "900*900>"}
  validates_attachment_content_type :image,
    :content_type => [ 'image/jpeg','image/jpg', 'image/png', 'image/gif','image/bmp', 'image/x-png', 'image/pjpeg' ]
  validates_attachment_presence :image
  validates_attachment_size(:image, :less_than => 10.megabytes)
end
