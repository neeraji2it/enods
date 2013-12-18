class ProductsController < ApplicationController
  before_filter :is_signin?, :only => ['index','new','create','preview_product']
  before_filter :is_valid_account? , :only => ['index','new','create']

  def index
    @products = Product.where("user_id = #{current_user.id}").order('product_count DESC').paginate :page => params[:product_page], :per_page => 10 if (user_signed_in? and current_user.role == 'seller')
  end

  def new
    @product = Product.new
    1.times {@product.images.build}
    1.times {@product.colors.build}
  end

  def create
    @product = Product.new(params[:product].merge(:user_id => current_user.id))
    @product.status = 'pending'
    if @product.images.blank?
      1.times { @product.images.build }
    end
    if @product.colors.blank?
      1.times { @product.colors.build }
    end
    if @product.save
      #@product.post
      flash[:success] = "Successfully create the project."
      redirect_to products_path
    else
      flash[:error] = "Failed to create the project."
      render :action => 'new'
    end
  end

  def show
    @product = Product.find(params[:id])
    @reviews = @product.reviews.order("created_at Desc").paginate :page => params[:review_page], :per_page => 1
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(params[:product])
      flash[:success] = "Successfully updated the Product."
      redirect_to products_path if current_user.role == 'seller'
      redirect_to products_admins_path if current_user.role == 'admin'
    else
      flash[:error] = "Fail to update product"
      render :action => 'edit'
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path if current_user.role == 'seller'
    redirect_to products_admins_path if current_user.role == 'admin'
  end

  def search
    @products = Product.where("title = '#{params[:query]}'")
    render :action => 'index'
  end

  def add_to_cart
    @cart = current_cart
    product = Product.find(params[:id])
    @cart.update_attribute(:created_at, Time.now)
    @line_item = @cart.add_item(product.id, params[:qty].to_i)
    @line_item.unit_price = product.price
    @line_item.status = params[:colour] if params[:colour].present?
    session[:cart] = @cart.id
    if @line_item.save
      redirect_to carts_path
    end
  end
  
  def preview_product
    @product = Product.find(params[:id])
    render :layout => false
  end
  
  def review
    @product = Product.find(params[:id])
    @review = @product.reviews.new
    render :layout => false
  end
  
  def product_review
    @product = Product.find(params[:id])
    @review = @product.reviews.new(params[:review])
    if @review.save
      respond_to do |format|
        format.js
      end
    end
  end
end