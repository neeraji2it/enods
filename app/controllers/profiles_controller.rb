class ProfilesController < ApplicationController
  before_filter :is_signin?
  before_filter :is_valid_account?, :only => ['order_history','dashboard']

  def profile
    @user = User.find(params[:id])
  end

  def profile_update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated your profile."
      redirect_to profile_profile_path(@user)
    else
      flash[:error] = "Fail to update your profile"
      render :action => 'profile'
    end
  end

  def change_password
    @user = current_user
    @user.errors.add(:password, "is required") if params[:user].nil? or params[:user][:password].to_s.blank?
    if @user.errors.empty? and @user.update_with_password(params[:user])
      sign_in(:user, @user, :bypass => true)
      flash[:notice] = 'Your password changed successfully'
      redirect_to profile_profile_path(@user)
    else
      flash.now[:error] = 'Password changing failed'
      render :action => "profile"
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def order_history
    @order_buyers = Order.where("user_id = #{current_user.id}").paginate :page => params[:order_buyer], :per_page => 10 if current_user.role == 'buyer'
    @order_sellers = Order.where("(status = 'Success' or status = 'Cancel') and receiver_id = #{current_user.id}").paginate :page => params[:order_seller], :per_page => 10 if current_user.role == 'seller'
  end

  def dashboard
    @sale = Order.where("created_at LIKE '%#{Date.today.strftime('%Y-%m-%d')}%'").sum {|item| item.line_item.product.price.to_i}
    @net_payment = Order.where("created_at LIKE '%#{Date.today.strftime('%Y-%m-%d')}%'").sum {|item| item.net_payment.to_i}
    @admin_payment = Order.where("created_at LIKE '%#{Date.today.strftime('%Y-%m-%d')}%'").sum {|item| item.admin_payment.to_i}
    @non_profit_payment = Order.where("created_at LIKE '%#{Date.today.strftime('%Y-%m-%d')}%'").sum {|item| item.non_profit_payment.to_i}
    @top_sellings = Order.where("(status = 'Success' or status = 'Cancel')").order('created_at Asc').paginate :page => params[:top_selling], :per_page => 5
    @latest_customers = Order.where("(status = 'Success' or status = 'Cancel') and receiver_id = #{current_user.id}").order('created_at Asc').paginate :page => params[:latest_customer], :per_page => 4
  end
end
