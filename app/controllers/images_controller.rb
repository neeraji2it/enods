class ImagesController < ApplicationController
  before_filter :is_signin?
  def index
    @product = Product.find(params[:product_id])
    @images = @product.images
  end
  
  def edit
    @product = Product.find(params[:product_id])
    @image = Image.find(params[:id])
  end
  
  def update
    @product = Product.find(params[:product_id])
    @image = Image.find(params[:id])
    if @image.update_attributes(params[:image])
      redirect_to product_images_path(@product)
    else
      render :action => 'edit'
    end      
  end
  
  def destroy
    @product = Product.find(params[:product_id])
    @image = Image.find(params[:id])
    @image.destroy
    redirect_to product_images_path(@product)
  end
end
