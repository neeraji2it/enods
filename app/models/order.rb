class Order < ActiveRecord::Base
  attr_accessible :user_id,:cart_id,:product_id,:receiver_id,:line_item_id,:status,:paykey,:cancel_date,:confirm_date, :details, :payment_type, :net_payment, :admin_payment, :non_profit_payment
  belongs_to :user
  belongs_to :line_item
  belongs_to :cart
  
  PAYMENT = {
    :paid => "Completed",
    :pending => "INCOMPLETE"
  }

  before_validation :set_payments_and_dates

  def paypal_url(paypal_return_url, paypal_cancel_url, paypal_ipn_url)
    primary_paypal_email = self.line_item.product.user.paypal_id
    seller_email = 'kapil07517@gmail.com'

    @api = PayPal::SDK::AdaptivePayments.new
    @pay = @api.build_pay(
      {:actionType => "PAY",
        :cancelUrl => paypal_cancel_url,
        :currencyCode => "USD",
        :feesPayer => "EACHRECEIVER",
        :ipnNotificationUrl => paypal_ipn_url,
        :receiverList => {
          :receiver => [
            {:amount => (self.admin_payment.to_i+self.non_profit_payment.to_i), :email => seller_email, :primary => false},
            {:amount => self.line_item.full_price, :email => primary_paypal_email, :primary => true}]
        },
        :return_url => paypal_return_url})

    @response = @api.pay(@pay)

    if @response.success?
      self.cart.update_attribute(:paypal_express_token, @response.payKey) if @response.payKey
      self.update_attributes({
          :paykey => @response.payKey,
          :details => @response,
          :status => @response.responseEnvelope.ack
        })
      return @api.payment_url(@response)
    else
      Rails.logger.warn @response.error[0].message
      return "/"#0current_domain
    end
  end

  private
  def set_payments_and_dates
    self.admin_payment = (self.line_item.full_price.to_i)/10
    self.non_profit_payment = (self.line_item.full_price.to_i-self.admin_payment.to_i)/15
    self.net_payment = self.line_item.full_price.to_i-self.admin_payment.to_i-self.non_profit_payment.to_i
    self.confirm_date = Time.now
  end
end
