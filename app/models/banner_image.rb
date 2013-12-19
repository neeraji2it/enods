class BannerImage < ActiveRecord::Base
  attr_accessible :image,:image_description
  has_attached_file :image, :styles => {:thumb => "90*90>", :large => "900*900>"} if Rails.env == 'development'
  has_attached_file :image,:whiny => false,:storage => :s3,:s3_credentials => "#{Rails.root}/config/s3.yml",:path => "uploaded_files/profile/:id/:style/:basename.:extension",:bucket => "enods-web",:styles => {:original => "900x900>",:default => "280x190>",:other => "96x96>"} if Rails.env == 'production'
  validates_attachment_content_type :image,
    :content_type => [ 'image/jpeg','image/jpg', 'image/png', 'image/gif','image/bmp', 'image/x-png', 'image/pjpeg' ]
  validates_attachment_presence :image
  validates_attachment_size(:image, :less_than => 10.megabytes)
  validates :image_description, :presence => true

  validate :set_dimensions

  private
  
  def set_dimensions(width = 708, height = 389)
    tempfile = self.image.queued_for_write[:original]
    unless tempfile.nil?
      dimensions = Paperclip::Geometry.from_file(tempfile)
      unless dimensions.width == width && dimensions.height == height
        errors.add :image, "Width must be #{width}px and height must be #{height}px"
      end
    end
  end
end
