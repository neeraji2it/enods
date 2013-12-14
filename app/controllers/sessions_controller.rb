class SessionsController < Devise::SessionsController
  def new
  end

  def create
    resource = warden.authenticate!(:scope => resource_name)
    sign_in(resource_name, resource)
    redirect_to after_sign_in_path_for(resource)
  end
end
