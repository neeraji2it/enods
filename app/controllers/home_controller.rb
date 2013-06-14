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
    @email_alert = EmailAlert.new(params[:email_alert])
    if @email_alert.save
      UserMailer.alert(@email_alert).deliver
      flash[:notice] = "Successfully Subscribed for this site."
      redirect_to root_path
    else
      render :action => 'launch', :layout => false
    end
  end

  def launch
    @email_alert = EmailAlert.new
    render :layout => false
  end
end
