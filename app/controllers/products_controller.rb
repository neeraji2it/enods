class ProductsController < ApplicationController
  before_filter :is_signin?, :only => ['new','create','add_to_cart']

  def index
    @products = Product.where("status = 'confirmed'").order('product_count DESC')
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

  def search
    @products = Product.where("title = '#{params[:query]}'")
    render :action => 'index'
  end

  def add_to_cart
    @cart = current_cart
    product = Product.find(params[:id])
    if product.user_id != current_user.id
      if !@cart.line_items.find_by_product_id(product).present?
        @cart.line_items.build(:cart_id => current_cart.id, :product_id => params[:id], :unit_price =>  product.price,:quantity => 1)
        if @cart.save
          session[:cart_id] = @cart.id
          flash[:notice] = "Successfully added to your cart"
          redirect_to carts_path
        end
      else
        flash[:error] = "Already added this product to your cart"
        redirect_to product_path(product)
      end
    else
      flash[:error] = "You are not added to your product to cart"
      redirect_to product_path(product)
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
