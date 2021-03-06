class HomeController < ApplicationController
  before_filter :admin?
  def index
    @products = Product.where("status = 'confirmed'").order('product_count DESC')
    @causes = Cause.all
    @email_alert = EmailAlert.new
  end

  def category
    conditions = !params[:categories].to_s.blank? ? "category_id = '#{params[:categories]}' and status = 'confirmed'" : "status = 'confirmed'"
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
  
  def all_causes
    if params[:cause_type]
      @causes = Cause.where("cause_type = '#{params[:cause_type]}'").paginate :page => params[:cause_page], :per_page => 5
    else
      @causes = Cause.paginate :page => params[:cause_page], :per_page => 5
    end
  end
  
  def search_causes
    @causes = Cause.where("title LIKE '%#{params[:query]}%'").paginate :page => params[:cause_page], :per_page => 5
    render :action => 'all_causes'
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
    @following = Follow.find_by_user_id_and_receiver_id_and_status(current_user.id, @user.id, 'Follow') if current_user
    @favoritee = FavoriteUser.find_by_user_id_and_receiver_id_and_status(current_user.id, @user.id, 'Favorited') if current_user
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
