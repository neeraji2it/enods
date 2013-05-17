class HomeController < ApplicationController

  def index
    @products = Product.where("status = 'confirmed'").order('product_count DESC')
    @email_alert = EmailAlert.new
  end

  def category
    conditions = !params[:categories].to_s.blank? ? "category_id = '#{params[:categories]}' and status = 'confirmed'" : ""
    @products = Product.find(:all, :conditions => [conditions])
    render :action => 'index'
  end

  def create_alert
    @products = Product.where("status = 'confirmed'").order('product_count DESC')
    @email_alert = EmailAlert.new(params[:email_alert])
    if @email_alert.save
      redirect_to root_path
    else
      render :action => 'index'
    end
  end
end
