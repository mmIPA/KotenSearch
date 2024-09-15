class Users::RegistrationsController < Devise::RegistrationsController
  
  def edit
    super
  end
  
  protected
  
  def after_update_path_for(resource)
    user_path(resource)
  end

  def update_resource(resource, params)
    if params[:password].present?
      super
    else
      resource.update_without_password(params.except("current_password"))
    end
  end
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email])
  end
  
end
