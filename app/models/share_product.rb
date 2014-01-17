class ShareProduct < ActiveRecord::Base
  CONSUMER_KEY = '5tvBo9ZJsphDXAEiT6SDDA'
  CONSUMER_SECRET = 'MOqoy57FHqTWqRJ25MzkLg8sMqgRZMEuKufyjxVZA'
  attr_accessible :uid, :secret, :provider, :token, :details, :product_id
  belongs_to :product
  
  def self.find_or_create(auth_hash)
    uid = auth_hash["uid"]
    details = auth_hash
    secret = auth_hash["secret"]
    provider = auth_hash["provider"]
    token = auth_hash["credentials"].try(:"[]", "token")
    share_product = ShareProduct.new :details => details, :secret => secret, :uid => uid, :provider => provider, :token => token
    share_product.save(:validate => false)
  end
  
  def post
    if self.provider == 'facebook'
      me = FbGraph::User.me(self.token)
      me.feed!(
        :message => self.product.title,
        :picture => self.product.images.first.image.url(:original)
      )
    elsif self.provider == 'twitter'
      Twitter.configure do |config|
        config.consumer_key = ShareProduct::CONSUMER_KEY
        config.consumer_secret = ShareProduct::CONSUMER_SECRET
        config.oauth_token = self.token
        config.oauth_token_secret = self.secret
      end
      client = Twitter::Client.new
      begin
        client.update(
          :message => self.title,
          :picture => self.product.images.first.image.url(:original)
        )
        return true
      rescue Exception => e
        self.errors.add(:oauth_token, "Unable to send to twitter: #{e.to_s}")
        return false
      end
    end
  end
end
