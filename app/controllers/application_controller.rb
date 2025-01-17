class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    
  private
 
  def admin_controller?
    self.class.module_parent_name == 'Admin'
  end
  
  def record_not_found
    redirect_to request.referer || root_path, alert: 'リソースが見つかりませんでした。'
  end
  
  protected
  
  def after_sign_in_path_for(resource)
    if resource.is_a?(User)
      mypage_path
    elsif resource.is_a?(Admin)
      admin_dashboards_path
    else
      super
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
