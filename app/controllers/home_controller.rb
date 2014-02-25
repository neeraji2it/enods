class HomeController < ApplicationController

  def index
    @products = Product.where("status = 'confirmed'").order('product_count DESC')
    @causes = Cause.all
    @email_alert = EmailAlert.new
  end

  def category
    conditions = !params[:categories].to_s.blank? ? "category_id = '#{params[:categories]}' and status = 'confirmed'" : ""
    @products = Product.find(:all, :conditions => [conditions])
  end

  def create_alert
    @products = Product.where("status = 'confirmed'").order('product_count DESC')
    @causes = Cause.all
    @email_alert = EmailAlert.new(params[:email_alert])
    if @email_alert.save
      UserMailer.alert(@email_alert).deliver
      flash[:success] = "Thank you for subscribing to our mailing list!"
      redirect_to root_path
    else
      render :action => 'index'
    end
  end
  
  def sell
    
  end
  
  def causess
    @causes = Cause.all
    @products = Product.where("status = 'confirmed' and non_profit_cause = 'Any'").order('product_count DESC').paginate :page => params[:page], :per_page => 25
  end
  
  def all_causes
    
  end

  def launch
    @email_alert = EmailAlert.new
    render :layout => false
  end
  
  def about_us
  end
  
  def delivary_information
  end
  
  def privacy_policy
  end
  
  def terms_conditions
  end
  
  def contact_us
    @contact = Contact.new
  end
  
  def seller
    @user = User.find(params[:id])
    @products = Product.where("user_id = #{@user.id} and status = 'confirmed'").order("created_at Desc")
  end
  
  def contact
    @contact = Contact.new(params[:contact])
    if @contact.save
      UserMailer.contact(@contact).deliver
      respond_to do |format|
        format.js
      end
    end
  end
  
  def shipping_returns
  end
  
  def secure_shopping
  end
  
  def how_it_works
  end
  
  def faqs
  end
end
