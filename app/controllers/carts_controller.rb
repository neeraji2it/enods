class CartsController < ApplicationController
  def index
    @cart = current_cart
    @user_products = current_cart.line_items
    @order = @cart.orders.new(params[:order])
    @comment = Comment.new
  end
  
  def edit_lineitem
    @line_item = LineItem.find(params[:id])
    @comment = Comment.new
    respond_to do |format|
      format.js
    end
  end
  
  def update_lineitem
    @cart = current_cart
    @user_products = current_cart.line_items
    @order = @cart.orders.new(params[:order])
    @line_item = LineItem.find(params[:id])
    @comment = Comment.new
    if @line_item.product.qty >= params[:line_item][:quantity].to_i
      @line_item.update_attribute(:quantity, params[:line_item][:quantity])
      respond_to do |format|
        format.js
      end
    else
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
    @cart = LineItem.find(params[:id])
    if @cart.destroy
      if !current_cart.line_items.present?
        current_cart.destroy
        session[:cart] = nil
      end
      redirect_to carts_path
    end
  end
end
