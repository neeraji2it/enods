class AdminsController < ApplicationController
  before_filter :is_signin?

  def admin_dashboard
    @pending_products = Product.where("status = 'pending'").paginate :page => params[:pending_product], :per_page => 4
    @orders = Order.where("status = 'Success' or status = 'Cancel'").paginate :page => params[:latest_order], :per_page => 8
  end
  
  def week
    respond_to do |format|
      format.js
    end
  end
  
  def index
  end

  def seller
    @users = User.where("role = 'seller'").paginate :page => params[:seller_page], :per_page => 10
  end

  def buyer
    @users = User.where("role = 'buyer'").paginate :page => params[:buyer_page], :per_page => 10
  end

  def non_profit
    @users = User.where("role = 'non-profit'").paginate :page => params[:non_page], :per_page => 10
  end

  def sales
    @orders = Order.where("status = 'Success'").paginate :page => params[:order_page], :per_page => 10
  end

  def products
    @products = Product.where("title IS NOT NULL").order('product_count DESC').paginate :page => params[:product_page], :per_page => 10
  end

  def confirm_product
    @product = Product.find(params[:id])
    @product.update_attributes({
        :status => params[:status],
        :color => 'Confirm'
      })
    @email_alerts = EmailAlert.all
    #    for email in @email_alerts
    #      UserMailer.project_alert(email,@product).deliver if (email.present? and params[:status] == 'confirmed')
    #    end
    redirect_to admin_dashboard_path
  end
  
  def reject_product
    @product = Product.find(params[:id])
    @product.update_attributes({
        :status => params[:status],
        :color => 'Confirm',
        :reject_message => params[:product][:reject_message]
      })
    @email_alerts = EmailAlert.all
    #    for email in @email_alerts
    #      UserMailer.project_alert(email,@product).deliver if (email.present? and params[:status] == 'confirmed')
    #    end
    redirect_to admin_dashboard_path
  end
  
  def review_product
    @products = Product.where("color = 'Modify'").paginate :page => params[:product_review], :per_page => 10
  end
end
