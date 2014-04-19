class ConstantsController < ApplicationController
  before_filter :is_signin?
  def follow
    @user = User.find(params[:id])
    @products = Product.where("user_id = #{@user.id} and status = 'confirmed'").order("created_at Desc")
    @current_user = current_user
    @follow = Follow.find_by_user_id_and_receiver_id(@current_user.id,@user.id)
    @follow.present? ? (@follow.update_attribute(:status, @follow.status == 'Follow' ? 'Unfollow' : 'Follow')) : (Follow.create(:user_id => @current_user.id, :receiver_id => @user.id, :status => 'Follow')) if @user.id != @current_user.id
    redirect_to seller_path(@user)
  end
  
  def favorite
    @user = User.find(params[:id])
    @products = Product.where("user_id = #{@user.id} and status = 'confirmed'").order("created_at Desc")
    @current_user = current_user
    @follow = FavoriteUser.find_by_user_id_and_receiver_id(@current_user.id,@user.id)
    @follow.present? ? (@follow.update_attribute(:status, @follow.status == 'Favorited' ? 'Favorite' : 'Favorited')) : (FavoriteUser.create(:user_id => @current_user.id, :receiver_id => @user.id, :status => 'Favorited'))  if @user.id != @current_user.id
    redirect_to seller_path(@user)
  end
end
