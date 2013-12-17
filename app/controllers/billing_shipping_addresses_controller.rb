class BillingShippingAddressesController < ApplicationController
  before_filter :is_signin?
  before_filter :is_valid_account?
  def new
    @billingshippingaddress = BillingShippingAddress.new
  end

  def create
    @billingshippingaddress = BillingShippingAddress.new(params[:billing_shipping_address].merge(:user_id => current_user.id))
    if @billingshippingaddress.save
      flash[:success] = "Successfully Created the Billing and Shipping Address"
      redirect_to profile_profile_path(current_user)
    else
      flash[:error] = "Failed to create the Billing and Shipping Address"
      render :action => 'new'
    end
  end
  
  def edit
    @billingshippingaddress = BillingShippingAddress.find(params[:id])
  end
  
  def update
    @billingshippingaddress = BillingShippingAddress.find(params[:id])
    if @billingshippingaddress.update_attributes(params[:billing_shipping_address])
      redirect_to profile_profile_path(current_user)
    else
      render :action => 'edit'
    end
  end
end
