class AdminsController < ApplicationController
  before_filter :is_signin?

  def admin_dashboard
    
  end

  def index
    @users = User.where("role = 'seller'")  if params[:role] == 'seller'
    @users = User.where("role = 'buyer'")  if params[:role] == 'buyer'
    @users = User.where("role = 'non-profit'")  if params[:role] == 'non-profit'
  end

  def products
    @pending_products = Product.where("status = 'pending'")
    @confirmed_products = Product.where("status = 'confirmed'")
  end

  def confirm_product
    @product = Product.find(params[:id])
    @product.update_attribute(:status, 'confirmed')
    redirect_to products_admins_path
  end
end
