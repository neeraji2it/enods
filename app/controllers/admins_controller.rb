class AdminsController < ApplicationController
  before_filter :is_signin?

  def admin_dashboard
    @pending_products = Product.where("status = 'pending'")
    @orders = Order.all
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
    @users = User.where("role = 'seller'")
  end

  def buyer
    @users = User.where("role = 'buyer'")
  end

  def non_profit
    @users = User.where("role = 'non-profit'")
  end

  def sales
    @orders = Order.where("status =='Completed'")
  end

  def products
    @products = Product.all
  end

  def confirm_product
    @product = Product.find(params[:id])
    @product.update_attribute(:status, 'confirmed')
    redirect_to products_admins_path
  end
end
