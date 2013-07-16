class AdaptivePaymentsController < ApplicationController
  include PayPal::SDK::AdaptivePayments
  def pay
    redirect_to new_product_order_path(current_cart.product_id), :notice => "Request completed"
  end

  def cancel
    redirect_to root_path
  end

  def ipn_notify
    current_cart.orders.each do |ord|
      ord.update_attributes({:status => "Success", :payment_type => "PAYPAL"})
    end
    current_cart.update_attribute(:purchased_at, Time.now)
    if PayPal::SDK::Core::API::IPN.valid?(request.raw_post)
      @registration = Order.find_by_paykey(params["pay_key"])
      @registration.update_attributes(:transaction_id => params["transaction"]["1"][".id"], :status => params["status"])
      render :text => "SUCCESS", :status => :ok
    else
      logger.info("IPN message: INVALID")
      render :text => "INVALID"
    end
  end
end
