class EmailAlert < ActiveRecord::Base
  attr_accessible :email
  validates :email, :uniqueness => true, :presence => true
end
