class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.role = params[:user][:role]
    if @user.save
      flash[:notice] = 'OK!  Please check your email to complete your registration.'
      redirect_to '/'
    else
      render :action => 'buyer'
    end
  end
end
