class AdaptivePaymentsController < ApplicationController
  include PayPal::SDK::AdaptivePayments
  def pay
    redirect_to paypal_ipn_path()
  end

  def cancel
    current_cart.orders.each do |ord|
      ord.update_attributes({
          :status => "Cancel",
          :cancel_date => Time.now,
          :receiver_id => ord.line_item.product.user_id
        })
    end
    current_cart.update_attribute(:purchased_at, Time.now)
    redirect_to order_history_path
  end

  def ipn_notify
    current_cart.orders.each do |ord|
      ord.update_attributes({
          :status => "Success",
          :payment_type => "PAYPAL",
          :shipping => 'In process',
          :receiver_id => ord.line_item.product.user_id
        })
      ord.line_item.product.update_attributes({
          :qty => ord.line_item.product.qty - ord.line_item.quantity,
          :qty_sold => ord.line_item.quantity
        })
      UserMailer.vendor_status(ord.line_item.product.user).deliver
    end
    UserMailer.user_status(current_user).deliver
    current_cart.update_attribute(:purchased_at, Time.now)
    session[:cart] = nil
    redirect_to order_history_path
  end
end
