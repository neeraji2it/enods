class Category < ActiveRecord::Base
  attr_accessible :name, :parent_id
  has_many :products, :dependent => :destroy
  validates :name, :presence => true

  def to_param
    "#{id} #{name}".parameterize
  end
end
