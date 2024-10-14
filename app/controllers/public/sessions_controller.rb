# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :is_deleted?, only: [:create]
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  
  protected

  # def after_sign_in_path_for(resource)
  #   admin_dashboards_path
  # end

  # def after_sign_out_path_for(resource_or_scope)
  #   new_admin_session_path
  # end
  
  def is_deleted?
    @user = User.find_by(email: params[:user][:email])
    return if !@user
    if @user.valid_password?(params[:user][:password]) && @user.is_deleted
      redirect_to new_user_registration_path, alert: 'このアカウントは退会済みです。'
    end
  end
end
