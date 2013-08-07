class OrdersController < ApplicationController
  def new
    @order = Order.new(:paykey => current_cart.paypal_express_token)
  end

  def create
    @line_item = LineItem.find(params[:line_item_id])
    @registration = @line_item.orders.new(params[:order])
    @registration.user_id = current_user.id
    respond_to do |format|
      if @registration.save
        current_cart.update_attributes({:created_at => Time.now, :product_id => @line_item.product_id})
        @registration.update_attributes({:cart_id => current_cart.id, :line_item_id => @line_item.id, :product_id => @line_item.product_id})
        @path = @registration.paypal_url(paypal_return_url, paypal_cancel_url, paypal_ipn_url)
        format.html {redirect_to @path}
      else
        format.html {render :action => :new}
      end
    end
  end

  def order_history
    @orders = Order.where("user_id = #{current_user.id} and status = 'Success'")
  end
end
