class OmniauthsController < ApplicationController

  def create
    auth = request.env['omniauth.auth']

    unless @auth = User.find_from_hash(auth)
      @auth = User.find_or_create(auth)
    end

    @auth.update_attributes({
      :token => auth['credentials']['token']
    })

    unless @auth.confirmed?
      @auth.confirm!
    end

    @user = @auth
    session[:fb_token] = auth['credentials']['token'] if @auth['provider'] == 'facebook'
    if @user.persisted?
      flash[:notice] = "Signed in successfully."
      sign_in(@user)
      redirect_to products_path
    else
      flash[:notice] = "Login failed."
      redirect_to new_user_registration_url
    end
  end
end
