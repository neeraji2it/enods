class ProductsController < ApplicationController
  before_filter :is_signin?, :only => ['index','new','create','preview_product','review','product_review']
  before_filter :is_seller? , :only => ['new','create','import','upload_products']
  before_filter :is_valid_account? , :only => ['index','new','create']

  def index
    @products = Product.where("user_id = #{current_user.id}").order('product_count DESC').paginate :page => params[:product_page], :per_page => 10 if (user_signed_in? and current_user.role == 'seller')
  end
  
  def import
  end
  
  def upload_products
    if request.post? && params[:file].present?
      CSV.foreach(params[:file].path, headers: false) do |row|
        @product = Product.new(:user_id => current_user.id, :title => row[0], :price => row[1], :sell_name => row[2], :status => 'pending')
        @product.save(:validate => false)
      end
      flash[:notice] = "Uploading completed."
      redirect_to products_path
    else
      flash[:error] = "Failed to Upload a file"
      render :action => 'import'
    end
  end

  def new
    @product = Product.new
    1.times {@product.images.build}
    1.times {@product.colors.build}
    1.times {@product.shipping_products.build}
  end
  
  def categories
    @categores = Category.where("parent_id = #{params[:category_id]}")
    respond_to do |format|
      format.js
    end
  end
  
  def sub_categories
    @sub_categores = Category.where("parent_id = #{params[:category_id]}")
    puts @sub_categores.inspect
    respond_to do |format|
      format.js
    end
  end

  def create
    @product = Product.new(params[:product].merge(:user_id => current_user.id))
    @product.status = 'pending'
    1.times { @product.images.build } if @product.images.blank?
    1.times { @product.colors.build } if @product.colors.blank?
    1.times {@product.shipping_products.build} if @product.shipping_products.blank?
    if @product.save
      #@product.post
      flash[:success] = "Successfully create the project."
      redirect_to products_path
    else
      flash[:error] = "Failed to create the project."
      render :action => 'new'
    end
  end
  
  def create_comment
    @cart = current_cart
    @user_products = current_cart.line_items
    @order = @cart.orders.new(params[:order])
    @product = Product.find(params[:id])
    @line_item = LineItem.find(params[:line_item_id])
    @comment = @product.comments.new(params[:comment])
    if @comment.save
      respond_to do |format|
        format.js
      end
    end
  end

  def show
    @product = Product.find(params[:id])
    @category = Category.find(@product.category_id)
    ShareProduct.destroy_all
    @reviews = @product.reviews.paginate :page => params[:review_page], :per_page => 5
  end
  
  def sort_review
    @product = Product.find(params[:id])
    if params[:sort] == 'highest'
      @reviews = @product.reviews.order("rating Desc").paginate :page => params[:review_page], :per_page => 10
    elsif params[:sort] == 'lowest'
      @reviews = @product.reviews.order("rating Asc").paginate :page => params[:review_page], :per_page => 10
    else
      @reviews = @product.reviews.order("created_at #{params[:sort]}").paginate :page => params[:review_page], :per_page => 10
    end
    render :partial => 'total_reviews', :layout => false
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(params[:product])
      @product.update_attribute(:color, 'Modify')
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
    if params[:from].present? and params[:to].present?
      @products = Product.where("(price BETWEEN #{params[:from]} AND #{params[:to]})")
    else
      @products = Product.where("title = '#{params[:query]}'")
    end
  end

  def add_to_cart
    @cart = current_cart
    product = Product.find(params[:id])
    @cart.update_attribute(:created_at, Time.now)
    @line_item = @cart.add_item(product.id, params[:qty].to_i)
    if product.qty >= @line_item.quantity
      @line_item.unit_price = product.price
      @line_item.status = params[:colour] if params[:colour].present?
      session[:cart] = @cart.id
      if @line_item.save
        redirect_to carts_path
      end
    else
      flash[:error] = "Only #{product.qty} left in stock"
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
  end
  
  def product_review
    @product = Product.find(params[:id])
    @review = @product.reviews.new(params[:review].merge(:user_id => current_user.id))
    if @review.save
      flash[:success] = "Succefully given the review to this product"
      redirect_to product_path(@product)
    else
      flash[:error] = "Failed to review the product"
      render :action => 'review'
    end
  end
end