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

  def show
    @user = User.find(params[:id])
  end
end
