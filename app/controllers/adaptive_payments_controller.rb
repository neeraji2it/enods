class AdaptivePaymentsController < ApplicationController
  include PayPal::SDK::AdaptivePayments
  def pay
    redirect_to new_product_order_path(current_cart.product_id), :notice => "Request completed"
  end

  def cancel
    current_cart.orders.each do |ord|
      ord.update_attributes({:status => "Cancel", :cancel_date => Time.now})
    end
    current_cart.update_attribute(:purchased_at, Time.now)
    redirect_to order_history_path
  end

  def ipn_notify
    current_cart.orders.each do |ord|
      ord.update_attributes({:status => "Success", :payment_type => "PAYPAL"})
      ord.product.update_attributes({:qty => ord.product.qty-1, :qty_sold => ord.product.qty_sold+1})
    end
    current_cart.update_attribute(:purchased_at, Time.now)
    redirect_to order_history_path
  end
end
