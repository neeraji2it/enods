class Contact < ActiveRecord::Base
  attr_accessible :name, :email, :message, :option
  validates :name, :email, :message, :presence => true
end
