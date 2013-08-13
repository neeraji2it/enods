class BillingShippingAddressesController < ApplicationController
  before_filter :is_valid_account?
  def new
    @billingshippingaddress = BillingShippingAddress.new
  end

  def create
    @billingshippingaddress = BillingShippingAddress.new(params[:billing_shipping_address].merge(:user_id => current_user.id))
    if @billingshippingaddress.save
      flash[:notice] = "Successfully Created the Billing and Shipping Address"
      redirect_to root_path
    else
      flash[:error] = "Failed to create the Billing and Shipping Address"
      render :action => 'new'
    end
  end
end
