class OrdersController < ApplicationController
  before_filter :is_signin?
  def pay
    @line_item = LineItem.find(params[:line_item_id])
    @registration = @line_item.orders.new(params[:order])
    @registration.user_id = current_user.id
    @registration.size = params[:size].present? ? params[:size] : nil
    @registration.buyer_type = params[:type].present? ? params[:type] : nil
    @registration.color = params[:color].present? ? params[:color] : nil
    @registration.cause = params[:non_profit_cause].present? ? params[:non_profit_cause] : @line_item.product.non_profit_cause
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
  
  def shipping
    @line_item = LineItem.find(params[:line_item_id])
    @order = @line_item.orders.find(params[:id])
    @order.update_attribute(:shipping, "Shipped")
    redirect_to order_history_path
  end

  def order_history
    @orders = Order.where("user_id = #{current_user.id} and status = 'Success'")
  end
end
