class UsersController < ApplicationController

  def new
    @user = User.new
  end
  
  def buyer
    render :layout => false
  end

  def create
    @user = User.new(params[:user])
    @user.role = params[:user][:role]
    if @user.save
      flash[:success] = 'OK!  Please check your email to complete your registration.'
      redirect_to '/'
    else
      render :action => 'new'
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:success] = "Successfully deleted the user."
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
      flash[:success] = "Successfully updated the user details"
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
