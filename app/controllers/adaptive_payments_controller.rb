class AdaptivePaymentsController < ApplicationController
  include PayPal::SDK::AdaptivePayments
  def pay
    redirect_to new_line_item_order_path(current_cart.product_id), :notice => "Request completed"
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
      ord.line_item.product.update_attributes({:qty => ord.line_item.product.qty-ord.line_item.quantity, :qty_sold => ord.line_item.product.qty_sold+ord.line_item.quantity})
    end
    current_cart.update_attribute(:purchased_at, Time.now)
    redirect_to order_history_path
  end
end
