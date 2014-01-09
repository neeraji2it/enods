class OmniauthsController < ApplicationController

  def create
    auth = request.env['omniauth.auth']
    if request.env['omniauth.params']['action'] == "share"
      id = request.env['omniauth.params']['product_id']
      @product = Product.find(id)
      @auth = ShareProduct.find_or_create(auth)
      ShareProduct.first.update_attribute(:product_id, @product.id)
      ShareProduct.first.post
      redirect_to product_path(@product)
    else
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
        flash[:success] = "Signed in successfully."
        sign_in(@user)
        redirect_to after_sign_in_path_for(@user)
      else
        flash[:error] = "Login failed."
        redirect_to new_user_path(:role => 'buyer')
      end
    end
  end
end
