class ApplicationController < ActionController::Base
  protect_from_forgery
  helper :all
  helper_method :current_cart
  layout :layout


  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.is_a?(User)
      current_user.received_invitation.update_attribute(:status, 'Accepted') if current_user.received_invitation
      flash[:success] = "You have successfully logged in."
      if current_user.role == 'admin'
        admin_dashboard_path
      else
        session[:ss].present? ? session[:ss] : current_user.role != 'admin' ? '/index' : profile_profile_path(current_user)
      end
    end
  end

  def layout
    if current_user
      if current_user.role != 'admin' && (params[:controller] != 'profiles' && params[:controller] != 'billing_shipping_addresses' && params[:controller] != 'invitations' && (params[:controller] != 'products' || params[:action] == 'show'))
        "login"
      else
        "application"
      end
    else
      "login"
    end
    # or turn layout off for every devise controller:
  end

  def is_signin?
    unless current_user
      flash[:error] = "Please Login"
      session[:ss] = request.fullpath
      session[:cause] = params[:non_profit_cause]
      redirect_to '/users/sign_in'
    end
  end

  def is_admin?
    unless current_user.role == 'admin'
      flash[:error] = "Please Login"
      redirect_to '/'
    end
  end
  
  def admin?
    redirect_to admin_dashboard_path if (current_user && (current_user.role == 'admin') && params[:controller] == 'home' && params[:action] == 'index')
  end
  
  def is_seller?
    unless current_user.role == 'seller'
      flash[:error] = "You have no permission to access that page"
      redirect_to profile_profile_path(current_user)
    end
  end
  
  def is_buyer?
    unless current_user.role == 'buyer'
      flash[:error] = "You have no permission to access that page"
      redirect_to profile_profile_path(current_user)
    end
  end
  
  def current_cart(create_if_not_exist=false)
    ip = request.remote_ip
    cart = Cart.where(["purchased_at IS NULL and ip_address = '#{ip}'"]).first
    unless cart
      if create_if_not_exist
        cart = Cart.create
      else
        cart = Cart.new
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
