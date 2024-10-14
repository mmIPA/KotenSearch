module Public
  module Users
    class RegistrationsController < Devise::RegistrationsController
      
      def update
        if current_user.update_without_current_password(user_params)
          redirect_to mypage_path, notice: '更新が完了しました。'
        else
          render :edit
        end
      end

      def destroy
        super do |resource|
          redirect_to root_path, notice: '退会が完了しました。' if resource.destroyed?
        end
      end
      private

      def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password)
      end
    end
  end
end