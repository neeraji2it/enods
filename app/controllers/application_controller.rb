class ApplicationController < ActionController::Base
  protect_from_forgery
  helper :all
  helper_method :after_sign_in_path_for,:current_cart
  layout :layout


  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.is_a?(User)
      if current_user.role == 'non-profit'
        profile_path(current_user)
      elsif current_user.role == 'buyer'
        profile_profile_path(current_user)
      elsif current_user.role == 'seller'
        dashboard_path
      else
        admin_dashboard_path
      end
    end
  end

  def layout
    if current_user
      "application"
    else
      "login"
    end
    # or turn layout off for every devise controller:
  end

  def is_signin?
    unless current_user
      flash[:error] = "Please Login"
      redirect_to '/'
    end
  end

  def is_admin?
    unless current_user.role == 'admin'
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

  private

  def is_valid_account?
    if current_user.role == 'buyer'
      if current_user and (current_user.first_name.to_s.blank? or current_user.last_name.to_s.blank? or current_user.gender.to_s.blank? or current_user.date_of_birth.to_s.blank? or current_user.zip.to_s.blank? or current_user.city.to_s.blank?)
        flash[:error] = "Please complete your account information before proceeding."
        redirect_to profile_profile_path(current_user)
      end
    elsif current_user.role == 'seller'
      if current_user and (current_user.business_name.to_s.blank? or current_user.business_address.to_s.blank? or current_user.website_url.to_s.blank? or current_user.paypal_id.to_s.blank?)
        flash[:error] = "Please complete your account information before proceeding."
        redirect_to profile_profile_path(current_user)
      end
    end
  end
end
