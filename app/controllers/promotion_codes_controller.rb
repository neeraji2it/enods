class PromotionCodesController < ApplicationController
  before_filter :is_signin?, :is_admin?
  def index
    @promos = PromotionCode.all
  end
  
  def new
    @promo = PromotionCode.new
  end
  
  def create
    @promo = PromotionCode.new(params[:promotion_code])
    if @promo.save
      redirect_to promotion_codes_path
    else
      render :action => 'new'
    end
  end
  
  def edit
    @promo = PromotionCode.find(params[:id])
  end
  
  def update
    @promo = PromotionCode.find(params[:id])
    if @promo.update_attributes(params[:promotion_code])
      redirect_to promotion_codes_path
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @promo = PromotionCode.find(params[:id])
    @promo.destroy
    redirect_to promotion_codes_path
  end
end
