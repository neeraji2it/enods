class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password,:avatar,:image, :password_confirmation,:role,:uid,:details,:secret, :remember_me,:first_name,:last_name,:username,:gender,:agree_terms,:provider,:token,:business_name, :business_address, :website_url, :city, :state, :country, :phone,:zip,:confirmation_token, :confirmed_at
  has_many :products, :dependent => :destroy
  has_many :favourites, :dependent => :destroy

  has_attached_file :avatar, :styles => {:thumb => '90*90>', :large => '900*900>'}, :default_url => "/assets/bigavatar.png"

  def self.find_from_hash(hash)
    find_by_provider_and_uid(hash['provider'], hash['uid'])
  end

  def self.find_or_create(auth_hash)
    unless user = User.find_by_email(auth_hash["info"]["email"])
      username = auth_hash["info"]["name"]
      email = auth_hash["provider"] == 'twitter' ? auth_hash["info"]["nickname"] : auth_hash["info"]["email"]
      first_name = auth_hash["info"]["first_name"]
      last_name = auth_hash["info"]["last_name"]
      uid = auth_hash["uid"]
      image = auth_hash["info"]["image"]
      details = auth_hash
      secret = auth_hash["secret"]
      provider = auth_hash["provider"]
      token = auth_hash["credentials"].try(:"[]", "token")
      user = User.new :username => username,:first_name => first_name,:image => image,:role => 'buyer',:last_name => last_name, :email => email,:details => details, :secret => secret, :uid => uid, :provider => provider, :token => token
      user.save(:validate => false)
    end
    return user
  end


  def favorite_for(tweet)
    self.favourites.find_by_product_id(tweet)
  end

  def to_param
    "#{id} #{username}".parameterize
  end

  #  protected
  #  def confirmation_required?
  #    self.provider.nil?
  #  end
end
