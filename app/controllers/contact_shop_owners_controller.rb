class ContactShopOwnersController < ApplicationController
  before_filter :is_signin?
  
  def new
    @user = User.find(params[:user_id])
    @contact_shop = ContactShopOwner.new
  end
  
  def create
    @user = User.find(params[:user_id])
    @contact_shop = ContactShopOwner.new(params[:contact_shop_owner].merge(:user_id => current_user.id, :receiver_id => @user.id))
    if @contact_shop.save
      UserMailer.contact_shop(@contact_shop).deliver
      redirect_to profile_profile_path(current_user)
    else
      render :action => :new
    end
  end
end
