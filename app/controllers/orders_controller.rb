class OrdersController < ApplicationController

  def express
    response = EXPRESS_GATEWAY.setup_purchase(current_cart.build_order.price_in_cents,
      :ip                => request.remote_ip,
      :return_url        => paypal_return_orders_url,
      :cancel_return_url => cancel_orders_url,
      :description => current_cart.paypal_description
    )
    redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)
  end

  def cancel
    flash[:notice] = "Your transaction has been cancelled"
    redirect_to products_url
  end

  def paypal_return
    current_cart.update_attribute(:paypal_express_token, params[:token]) if params[:token]
    redirect_to new_order_url
  end

  def new
    @cart = current_cart
    @order = Order.new(:express_token => @cart.paypal_express_token)
  end

  def create
    params[:order] ||= {}
    @cart = current_cart
    @order = @cart.build_order(params[:order].merge({:ip_address => request.remote_ip, :cart_id => @cart.id, :user_id => current_user.id, :express_token => @cart.paypal_express_token}))
    if @order.save
      if @order.purchase
        session.delete(:cart_id)
        flash[:notice] = "Payment has been successfully done"
        redirect_to products_path
      else
        flash[:error] = "Your payment has failed. Please try again"
        redirect_to new_order_path
      end
    else
      flash[:error] = "Your payment has failed. Please try again"
      render :action => 'new'
    end
  end
end
