class ProductsController < ApplicationController
  before_filter :is_signin?, :only => ['index','new','create']
  before_filter :is_valid_account? , :only => ['index','new','create']

  def index
    @products = Product.where("user_id = #{current_user.id}").order('product_count DESC').paginate :page => params[:product_page], :per_page => 10 if (user_signed_in? and current_user.role == 'seller')
  end

  def new
    @product = Product.new
    1.times {@product.images.build}
  end

  def create
    @product = Product.new(params[:product].merge(:user_id => current_user.id))
    @product.status = 'pending'
    if @product.images.blank?
      1.times { @product.images.build }
    end
    if @product.save
      #@product.post
      flash[:notice] = "Successfully create the project."
      @email_alerts = EmailAlert.all
      for email in @email_alerts
        UserMailer.project_alert(email,@product).deliver if email.present?
      end
      redirect_to products_path
    else
      flash[:error] = "Failed to create the project."
      render :action => 'new'
    end
  end

  def show
    @product = Product.find(params[:id])
    @product.update_attribute(:product_count, @product.product_count+1)
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(params[:product])
      flash[:notice] = "Successfully updated the Product."
      redirect_to products_path
    else
      flash[:error] = "Fail to update product"
      render :action => 'edit'
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path
  end

  def search
    @products = Product.where("title = '#{params[:query]}'")
    render :action => 'index'
  end

  def add_to_cart
    @cart = current_cart
    product = Product.find(params[:id])
    @cart.update_attribute(:created_at, Time.now)
    @line_item = @cart.add_item(product.id)
    @line_item.unit_price = product.price
    session[:cart] = @cart.id
    if @line_item.save
      redirect_to carts_path
    end
  end

  def favourite
    @product = Product.find(params[:id])
    @favourite = Favourite.new(:user_id => current_user.id,:product_id=>@product.id,:status => true).save
    redirect_to products_path
  end

  def update_favourite
    @product = Product.find(params[:id])
    @favourite = @product.favourite.update_attribute(:status, false)
    redirect_to products_path
  end

  def update_mark_favourite
    @product = Product.find(params[:id])
    @favourite = @product.favourite.update_attribute(:status, true)
    redirect_to products_path
  end

  def favourites
    @favourites = Favourite.where("user_id = #{current_user.id} and status = #{true}")
  end
end
