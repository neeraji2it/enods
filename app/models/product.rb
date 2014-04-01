class Product < ActiveRecord::Base
  attr_accessible :title,:cause_id,:fair_trade,:non_profit_cause, :color,:shipping, :sell_name, :user_id,:status,:agree_terms, :description, :price, :colors_attributes, :images_attributes, :shipping_products_attributes,:category_id,:discount,:qty, :qty_sold, :non_profit_percentage, :cause_sub_category, :reject_message
  belongs_to :user
  belongs_to :category
  belongs_to :cause
  has_many :images, :dependent => :destroy
  has_many :comments, :as => :commentable
  has_many :colors, :dependent => :destroy
  has_many :shipping_products, :dependent => :destroy
  has_many :share_products, :dependent => :destroy
  has_many :reviews, :dependent => :destroy
  has_many :billing_shipping_addresses, :dependent => :destroy
  has_one :favourite, :dependent => :destroy
  validates :shipping, :presence => true, :on => :create
  validates :title, :sell_name,:agree_terms,:non_profit_cause, :description,:category_id, :presence => true
  validates :price,:non_profit_percentage, :numericality => {:greater_than_or_equal_to => 1}, :presence => true
  validates_numericality_of :qty, :greater_than_or_equal_to => 1
  accepts_nested_attributes_for :images,:shipping_products, :colors, :allow_destroy => true, :reject_if => :all_blank

  def to_param
    "#{id} #{title}".parameterize
  end
  
  def self.import(file,user_id)
    CSV.foreach(file.path) do |row|
      product = Product.new(:user_id => user_id,:status => 'pending',:title => row[0], :price => row[1], :images_attributes => {"0" => {:image => row[2]}}) 
      product.save(:validate => false)
    end
  end
end
