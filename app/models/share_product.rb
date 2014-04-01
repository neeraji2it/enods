class ShareProduct < ActiveRecord::Base
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
      product_details = {:message=>self.product.title,:picture => self.product.images.first.image.url(:original)}
      Twitter.configure do |config|
        config.consumer_key = "5tvBo9ZJsphDXAEiT6SDDA"
        config.consumer_secret = "MOqoy57FHqTWqRJ25MzkLg8sMqgRZMEuKufyjxVZA"
        config.oauth_token = self.token
        config.oauth_token_secret = self.secret
      end
      Twitter.update("#{product_details}")
    end
  end
end
