class Invitation < ActiveRecord::Base
  attr_accessible :sender_id, :email, :status
  validates :email, :presence => true
  belongs_to :sender, :class_name => 'User'
  has_one :recipient, :class_name => 'User', :primary_key => :email, :foreign_key => :email
end
