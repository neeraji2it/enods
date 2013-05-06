class UsersController < ApplicationController

  def buyer
    @user = User.new
  end

  def create_buyer
    @user = User.new(params[:user])
    @user.role = 'buyer'
    if @user.save
      flash[:notice] = 'OK!  Please check your email to complete your registration.'
      redirect_to '/'
    else
      render :action => 'buyer'
    end
  end

  def seller
    @user = User.new
  end

  def create_seller
    @user = User.new(params[:user])
    @user.role = 'seller'
    if @user.save
      flash[:notice] = 'OK!  Please check your email to complete your registration.'
      redirect_to '/'
    else
      render :action => 'seller'
    end
  end
end
