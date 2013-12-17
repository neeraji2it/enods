class BannerImagesController < ApplicationController
  before_filter :is_signin?, :is_admin?
  def index
    @banner_images = BannerImage.all
  end
  
  def new
    @banner_image = BannerImage.new
  end
  
  def create
    @banner_image = BannerImage.new(params[:banner_image])
    if @banner_image.save
      redirect_to banner_images_path
    else
      render :action => 'new'
    end
  end
  
  def edit
    @banner_image = BannerImage.find(params[:id])
  end
  
  def update
    @banner_image = BannerImage.find(params[:id])
    if @banner_image.update_attributes(params[:banner_image])
      redirect_to banner_images_path
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @banner_image = BannerImage.find(params[:id])
    @banner_image.destroy
    redirect_to banner_images_path
  end
end
