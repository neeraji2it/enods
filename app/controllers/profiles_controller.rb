class ProfilesController < ApplicationController
  before_filter :is_signin?

  def profile
    @user = User.find(params[:id])
  end

  def profile_update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated your profile."
      redirect_to profile_profile_path(@user)
    else
      flash[:error] = "Fail to update your profile"
      render :action => 'profile'
    end
  end

  def change_password
    @user = current_user
    @user.errors.add(:password, "is required") if params[:user].nil? or params[:user][:password].to_s.blank?
    if @user.errors.empty? and @user.update_with_password(params[:user])
      sign_in(:user, @user, :bypass => true)
      flash[:notice] = 'Your password changed successfully'
      redirect_to profile_profile_path(@user)
    else
      flash.now[:error] = 'Password changing failed'
      render :action => "profile"
    end
  end

  def show
    @user = User.find(params[:id])
  end
end
