class ApplicationController < ActionController::Base
  protect_from_forgery
  helper :all
  helper_method :after_sign_in_path_for,:current_cart


  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.is_a?(User)
      if current_user.role == 'admin'
        admins_path
      else
        products_path
      end
    end
  end

  def is_signin?
    unless current_user
      flash[:error] = "Please Login"
      redirect_to '/'
    end
  end

  def current_cart(create_if_not_exist=false)
    cart = current_user ? Cart.where(["id = ? AND user_id = ? AND purchased_at IS NULL", session[:cart_id], current_user.id]).first : Cart.new
    unless cart
      if create_if_not_exist
        cart = Cart.create(:user_id => (current_user ? current_user.id : nil))
        session[:cart_id] = cart.id
      else
        cart = Cart.new(:user_id => (current_user ? current_user.id : nil))
      end
    end
    cart
  end
end
