class Order < ActiveRecord::Base
  attr_accessible :user_id,:cart_id,:product_id,:status,:paykey,:cancel_date,:confirm_date, :details, :payment_type, :net_payment, :admin_payment, :non_profit_payment
  belongs_to :user
  belongs_to :product
  belongs_to :cart

  PAYMENT = {
    :paid => "Completed",
    :pending => "INCOMPLETE"
  }

  before_validation :set_payments_and_dates

  def paypal_url(paypal_return_url, paypal_cancel_url, paypal_ipn_url)
    primary_paypal_email = 'ashokkmr098@gmail.com'
    seller_email = self.product.user.paypal_id

    @api = PayPal::SDK::AdaptivePayments.new
    @pay = @api.build_pay(
      {:actionType => "PAY_PRIMARY",
        :cancelUrl => paypal_cancel_url,
        :currencyCode => "USD",
        :feesPayer => "EACHRECEIVER",
        :ipnNotificationUrl => paypal_ipn_url,
        :receiverList => {
          :receiver => [
            {:amount => 20, :email => seller_email, :primary => false},
            {:amount => 80, :email => primary_paypal_email, :primary => true}]
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
    self.net_payment = self.product.price
    self.confirm_date = Time.now
  end
end
