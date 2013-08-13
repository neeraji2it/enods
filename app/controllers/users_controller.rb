class UsersController < ApplicationController

  def new
    @user = User.new(:token => params[:token])
    @user.email = @user.invitation.email if @user.invitation
  end

  def create
    @user = User.new(params[:user])
    @user.role = params[:user][:role]
    if @user.save
      flash[:notice] = 'OK!  Please check your email to complete your registration.'
      redirect_to '/'
    else
      render :action => 'new'
    end
  end

  def buyer
    @user = User.new
    render :layout => false
  end

  def buyer_create
    @user = User.new(params[:user])
    @user.role = 'buyer'
    @user.username = @user.email.split("@").first
    @user.password = '12345678'
    @user.password_confirmation = '12345678'
    if @user.save
      @error = "OK!  Please check your email to complete your registration."
      respond_to do |format|
        format.js
      end
    else
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:notice] = "Successfully deleted the user."
      redirect_to products_admins_path
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @title = "Admin Panel"
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      if params[:active] == 'Deactive'
        @user.update_attributes({
            :active => "Deactive",
            :confirmation_token => "M5ysQarV6KCK5nxz67xu",
            :confirmed_at => ""
          })
      elsif params[:active] == 'Active'
        @user.update_attributes({
            :active => "Active",
            :confirmation_token => nil,
            :confirmed_at => Time.now
          })
      end
      flash[:notice] = "Successfully updated the user details"
      redirect_to admin_dashboard_path
    else
      render :action => 'edit'
    end
  end

  def username
    @user = params[:username]
    @username = User.find_by_username(@user)
    if !@username.present?
      respond_to do |format|
        format.js
      end
    else
      respond_to do |format|
        format.js
      end
    end
  end
end
