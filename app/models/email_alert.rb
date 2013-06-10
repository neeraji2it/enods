class EmailAlert < ActiveRecord::Base
  attr_accessible :email
  validates :email, :uniqueness => true,:format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }, :presence => true
end
