class CartsController < ApplicationController
  def index
    @cart = current_cart
    @user_products = current_cart.line_items
  end

  def destroy
    @cart = LineItem.find(params[:id])
    if @cart.destroy
      if !current_cart.line_items.present?
        current_cart.destroy
      end
      flash[:notice] = "Successfully deleted the cart"
      redirect_to products_path
    end
  end

  def expire_cart
    if current_cart.created_at
      current_cart.line_items.destroy
      inactive_carts = Cart.where(["user_id = #{current_user.id} AND purchased_at IS NULL AND created_at < '#{(current_cart.created_at.utc+(30*60)).strftime('%Y-%m-%d %H:%M:%S')}'"])
      inactive_carts.map{|inactive_cart| inactive_cart.destroy}
      flash[:notice] = "Your cart has expired. Please add the products to the cart to purchase it"
    end
    redirect_to products_path
  end
end
