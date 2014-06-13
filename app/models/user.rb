require 'paypal-sdk-adaptiveaccounts'
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :confirmable
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email,:active, :password,:avatar,:image,:store_image, :password_confirmation,:role,:uid,:details,:secret, :remember_me,:first_name,:last_name,:username,:gender,:agree_terms,:provider,:token,:business_name, :business_address, :website_url, :city, :state, :country, :phone,:zip,:confirmation_token, :confirmed_at,:paypal_id,:other_info,:date_of_birth
  has_many :products, :dependent => :destroy
  has_many :favourites, :dependent => :destroy
  has_many :invitations, :dependent => :destroy
  has_many :cause_fans, :dependent => :destroy
  has_many :received_contacts, :class_name => 'ContactShopOwner', :foreign_key => :receiver_id, :dependent => :destroy
  has_one :billing_shipping_address, :dependent => :destroy
  has_many :sent_invitations, :class_name => 'Invitation', :foreign_key => 'sender_id'
  has_many :followers, :class_name => "Follow", :foreign_key => 'receiver_id'
  has_many :favoriters, :class_name => "FavoriteUser", :foreign_key => 'receiver_id'
  has_one :received_invitation, :class_name => 'Invitation', :primary_key => :email, :foreign_key => :email
  validates :username,:presence => true,:uniqueness => true

  has_attached_file :avatar, :styles => {:thumb => '90*90>', :large => '900*900>'}, :default_url => "/assets/img-seller-infomation.jpg" if Rails.env == 'development'
  has_attached_file :avatar,:whiny => false,:storage => :s3,:s3_credentials => "#{Rails.root}/config/s3.yml",:path => "uploaded_files/profile/:id/:style/:basename.:extension",:bucket => "enods-web",:styles => {:original => "900x900>",:default => "280x190>",:other => "96x96>"}, :default_url => "/assets/img-seller-infomation.jpg" if Rails.env == 'production'
  has_attached_file :store_image, :styles => {:thumb => '90*90>', :large => '900*900>'}, :default_url => "/assets/img-dummy.jpg" if Rails.env == 'development'
  has_attached_file :store_image,:whiny => false,:storage => :s3,:s3_credentials => "#{Rails.root}/config/s3.yml",:path => "uploaded_files/profile/:id/:style/:basename.:extension",:bucket => "enods-web",:styles => {:original => "900x900>",:default => "280x190>",:other => "96x96>"}, :default_url => "/assets/img-dummy.jpg" if Rails.env == 'production'
  #validates :first_name,:last_name,:gender, :presence => true
  #validates :date_of_birth,:city,:zip, :presence => {:if => :buyer?}, :on => :update
  #  validate :valid_paypal, :on => :update
  #validates :business_name, :business_address, :website_url, :paypal_id, :presence => {:if => :seller?}, :on => :update

  #  def valid_paypal
  #    if self.role == "seller"
  #      api = PayPal::SDK::AdaptiveAccounts::API.new( :device_ipaddress => "127.0.0.1" )
  #
  #      # Build request object
  #      get_verified_status = api.build_get_verified_status({
  #          :emailAddress => self.paypal_id,
  #          :matchCriteria => "NONE" })
  #      get_verified_status_response = api.get_verified_status(get_verified_status)
  #      if get_verified_status_response.success?
  #      else
  #        errors.add(:paypal_id, "Id is Not valid")
  #        return false
  #      end
  #    end
  #  end
  
  def buyer?
    !self.role.nil? and ['buyer'].include?(self.role)
  end
  
  def self.total_on(date)
    where("date(created_at) = ?",date).count
  end

  def seller?
    !self.role.nil? and ['seller'].include?(self.role)
  end

  def self.find_from_hash(hash)
    find_by_provider_and_uid(hash['provider'], hash['uid'])
  end

  def self.find_or_create(auth_hash)
    unless user = User.find_by_email(auth_hash["info"]["email"])
      username = auth_hash["info"]["name"]
      email = (auth_hash["provider"] == 'twitter' or auth_hash["provider"] == 'yahoo') ? auth_hash["info"]["nickname"] : auth_hash["info"]["email"]
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

  protected
  def confirmation_required?
    self.provider.nil?
  end
end
