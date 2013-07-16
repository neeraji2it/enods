class OrdersController < ApplicationController
  def new
    @order = Order.new(:paykey => current_cart.paypal_express_token)
  end

  def create
    @product = Product.find(params[:product_id])
    @registration = @product.orders.new(params[:order])
    @registration.user_id = current_user.id
    respond_to do |format|
      if @registration.save
        current_cart.update_attributes({:created_at => Time.now, :product_id => @product.id})
        @registration.update_attribute(:cart_id, current_cart.id)
        @path = @registration.paypal_url(paypal_return_url, paypal_cancel_url, paypal_ipn_url)
        format.html {redirect_to @path}
      else
        format.html {render :action => :new}
      end
    end
  end
end
