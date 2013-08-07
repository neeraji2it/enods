class Product < ActiveRecord::Base
  attr_accessible :title,:fair_trade,:non_profit_email, :user_id,:status, :description, :price, :images_attributes,:category_id, :color, :qty, :qty_sold
  belongs_to :user
  belongs_to :category
  has_many :images, :dependent => :destroy
  has_many :billing_shipping_address, :dependent => :destroy
  has_one :favourite, :dependent => :destroy
  validates :title, :description,:category_id, :presence => true
  validates :qty, :price, :numericality => {:greater_than_or_equal_to => 1}, :presence => true

  accepts_nested_attributes_for :images, :allow_destroy => true, :reject_if => :all_blank

  def to_param
    "#{id} #{title}".parameterize
  end

#  def post
#    if current_user.provider == 'facebook'
#      me = FbGraph::User.me(self.user.oauth_token)
#      me.feed!(
#        :message => self.title,
#        :picture => "http://www.australia.com/contentimages/4.3.15.6_highlight.jpg"
#      )
#    else
#      Twitter.configure do |config|
#        config.consumer_key = 'wkSR9O44uuC6bdXshxDFg'
#        config.consumer_secret = 'hf3qQNEEF94f1OiURoNCa3LRjpEwq3bynXzC5BWvQ'
#        config.oauth_token = self.user.oauth_token
#        config.oauth_token_secret = self.user.oatuh_token_secert
#      end
#      client = Twitter::Client.new
#      begin
#        client.update(
#          :message => self.title
#        )
#        return true
#      rescue Exception => e
#        self.errors.add(:oauth_token, "Unable to send to twitter: #{e.to_s}")
#        return false
#      end
#    end
#  end
end
