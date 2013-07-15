class Invitation < ActiveRecord::Base
  attr_accessible :user_id, :email, :status
  validates :email, :uniqueness => true, :presence => true
  belongs_to :user
end
