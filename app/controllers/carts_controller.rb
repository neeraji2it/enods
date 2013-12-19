class CartsController < ApplicationController
  def index
    @cart = current_cart
    @user_products = current_cart.line_items
    @order = @cart.orders.new(params[:order])
  end
  
  def edit_lineitem
    @line_item = LineItem.find(params[:id])
    respond_to do |format|
      format.js
    end
  end
  
  def update_lineitem
    @cart = current_cart
    @user_products = current_cart.line_items
    @order = @cart.orders.new(params[:order])
    @line_item = LineItem.find(params[:id])
    @line_item.update_attribute(:quantity, params[:line_item][:quantity])
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @cart = LineItem.find(params[:id])
    if @cart.destroy
      if !current_cart.line_items.present?
        current_cart.destroy
        session[:cart] = nil
      end
      flash[:success] = "Successfully deleted the cart"
      redirect_to carts_path
    end
  end

  def expire_cart
    if current_cart.created_at
      current_cart.line_items.destroy
      inactive_carts = Cart.where(["(purchased_at IS NULL or product_id IS NULL) AND created_at < '#{(current_cart.created_at.utc+(30*60)).strftime('%Y-%m-%d %H:%M:%S')}'"])
      inactive_carts.map{|inactive_cart| inactive_cart.destroy}
      flash[:success] = "Your cart has expired. Please add the products to the cart to purchase it"
    end
    redirect_to carts_path
  end
end
