class Category < ActiveRecord::Base
  attr_accessible :name
  has_many :products, :dependent => :destroy
  validates :name, :uniqueness => true, :presence => true

  def to_param
    "#{id} #{name}".parameterize
  end
end
