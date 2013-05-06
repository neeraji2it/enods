class Order < ActiveRecord::Base
  attr_accessible :express_token,:ip_address, :cart_id, :user_id,:first_name,:last_name,:express_payer_id
  belongs_to :cart
  belongs_to :user
  has_many :transactions, :class_name => 'OrderTransaction'

  def purchase
    response = process_purchase
    transactions.create!(:action => "purchase", :amount => price_in_cents, :response => response)
    cart.update_attribute(:purchased_at, Time.now) if response.success?
    response.success?
  end

  def express_token=(token)
    write_attribute(:express_token, token)
    if new_record? && !token.blank?
      details = EXPRESS_GATEWAY.details_for(token)
      self.express_payer_id = details.payer_id
      self.first_name = details.params["first_name"]
      self.last_name = details.params["last_name"]
    end
  end

  def price_in_cents
    (cart.total_price*100).round
  end

  private

  def process_purchase
    EXPRESS_GATEWAY.purchase(price_in_cents, express_purchase_options)
  end

  def express_purchase_options
    {
      :ip => ip_address,
      :token => express_token,
      :payer_id => express_payer_id
    }
  end

end
