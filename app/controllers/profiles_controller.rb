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
    @order_buyers = Order.where("user_id = #{current_user.id} and paykey IS NOT NULL").paginate :page => params[:order_buyer], :per_page => 10 if current_user.role == 'buyer'
    @order_sellers = Order.where("(status = 'Success' or status = 'Cancel') and receiver_id = #{current_user.id}").paginate :page => params[:order_seller], :per_page => 10 if current_user.role == 'seller'
  end

  def dashboard
    @sale = Order.where("created_at LIKE '%#{Date.today.strftime('%Y-%m-%d')}%' and status = 'Success' and receiver_id = #{current_user.id}").sum {|item| item.line_item.product.price.to_i}
    @net_payment = Order.where("created_at LIKE '%#{Date.today.strftime('%Y-%m-%d')}%' and status = 'Success' and receiver_id = #{current_user.id}").sum {|item| item.net_payment.to_i}
    @admin_payment = Order.where("created_at LIKE '%#{Date.today.strftime('%Y-%m-%d')}%' and status = 'Success' and receiver_id = #{current_user.id}").sum {|item| item.admin_payment.to_i}
    @this_week_order = Order.where("(created_at BETWEEN '#{Time.now.beginning_of_week.strftime('%Y-%m-%d')}' AND '#{Time.now.strftime('%Y-%m-%d')}') and status = 'Success' and receiver_id = #{current_user.id}").sum {|item| item.net_payment.to_i}
    @this_week_order_avg = Order.where("(created_at BETWEEN '#{Time.now.beginning_of_week.strftime('%Y-%m-%d')}' AND '#{Time.now.strftime('%Y-%m-%d')}') and status = 'Success' and receiver_id = #{current_user.id}").sum {|item| item.net_payment.to_i/7}
    @non_profit_payment = Order.where("created_at LIKE '%#{Date.today.strftime('%Y-%m-%d')}%' and status = 'Success' and receiver_id = #{current_user.id}").sum {|item| item.non_profit_payment.to_i}
    @top_sellings = Order.where("(status = 'Success' or status = 'Cancel')").order('created_at Asc').paginate :page => params[:top_selling], :per_page => 5
    @latest_customers = Order.where("(status = 'Success' or status = 'Cancel') and receiver_id = #{current_user.id}").order('created_at Asc').paginate :page => params[:latest_customer], :per_page => 4
    @non_profit_contribution = Order.where("non_profit_email = '#{current_user.email}'").joins("left join products on products.id = orders.product_id").sum {|item| item.non_profit_payment.to_i}
    @non_profit_sales =  Order.where("non_profit_email = '#{current_user.email}'").joins("left join products on products.id = orders.product_id").paginate :page => params[:non_profit], :per_page => 4
  end
  
  def week
    respond_to do |format|
      format.js
    end
  end
end
