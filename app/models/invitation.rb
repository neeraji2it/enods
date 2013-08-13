class Invitation < ActiveRecord::Base
  attr_accessible :sender_id, :email, :status
  validates :email, :uniqueness => true, :presence => true
  belongs_to :sender, :class_name => 'User'
  has_one :recipient, :class_name => 'User', :primary_key => :email, :foreign_key => :email
  
  validate :recipient_is_not_registered
  private
  
  def recipient_is_not_registered
    errors.add :email, 'is already registered' if User.find_by_email(email)
  end
end
