class AdminsController < ApplicationController
  before_filter :is_signin?

  def admin_dashboard
    @pending_products = Product.where("status = 'pending'")
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
