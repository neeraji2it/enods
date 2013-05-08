class ProfilesController < ApplicationController

  def profile
    @user = User.find(params[:id])
  end

  def profile_update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated your profile."
      redirect_to products_path
    else
      flash[:error] = "Fail to update your profile"
      render :action => 'profile'
    end
  end

  def show
    @user = User.find(params[:id])
  end
end
