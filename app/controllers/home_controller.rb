class HomeController < ApplicationController

  def index
    @products = Product.where("status = 'confirmed'").order('product_count DESC')
  end

  def category
    conditions = !params[:categories].to_s.blank? ? "category_id = '#{params[:categories]}' and status = 'confirmed'" : ""
    @products = Product.find(:all, :conditions => [conditions])
    render :action => 'index'
  end
end
