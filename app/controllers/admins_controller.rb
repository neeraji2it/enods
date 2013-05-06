class AdminsController < ApplicationController
  def index
    @pending_products = Product.where("status = 'pending'")
    @confirmed_products = Product.where("status = 'confirmed'")
  end

  def confirm_product
    @product = Product.find(params[:id])
    @product.update_attribute(:status, 'confirmed')
    redirect_to admins_path
  end
end
