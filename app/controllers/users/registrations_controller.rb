class Users::RegistrationsController < Devise::RegistrationsController
    
  def update
    if current_user.update_without_current_password(user_params)
      redirect_to user_path(current_user), notice: '更新が完了しました。'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end

end