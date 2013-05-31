class SessionsController < Devise::SessionsController
  def new
    render :layout => false
  end

  def create
    resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
    sign_in(resource_name, resource)
    return render :json => {:success => true, :content => "Success", :redirectUrl => after_sign_in_path_for(resource)}.to_json
  end
end
