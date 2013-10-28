class AdminsController < ApplicationController
  before_filter :is_signin?

  def admin_dashboard
    @pending_products = Product.where("status = 'pending'").paginate :page => params[:pending_product], :per_page => 4
    @orders = Order.where("status = 'Success' or status = 'Cancel'").paginate :page => params[:latest_order], :per_page => 8
    @datess = (Time.now - 5.day).strftime("%m/%d/%Y")
    @likesqw = []
    @likesqw1 = []
    @time = Time.now.strftime("%d").to_i
    year = Time.now.year
    i = Time.now.strftime("%m").to_i
    (1..31).each do |time|
      xx = "#{year}-#{i}-#{time}".to_time
      @likes = User.where("role != 'admin' and created_at LIKE '%#{xx.to_date.strftime('%Y-%m-%d')}%'").count
      @clikes = Product.where("status = 'confirmed' and created_at LIKE '%#{xx.to_date.strftime('%Y-%m-%d')}%'").count
      @likesqw << [time,@likes]
      @likesqw1 << [time,@clikes]
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
    @products = Product.where("title IS NOT NULL").order('product_count DESC').paginate :page => params[:product_page], :per_page => 3
  end

  def confirm_product
    @product = Product.find(params[:id])
    @product.update_attribute(:status, 'confirmed')
    redirect_to admin_dashboard_path
  end
end
