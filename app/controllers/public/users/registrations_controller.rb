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
      
      def update
        if current_user.update_without_current_password(user_params)
          redirect_to mypage_path, notice: '更新が完了しました。'
        else
          render :edit
        end
      end
      
      def destroy
        @user = current_user
        if @user.update(is_deleted: true)
          sign_out @user
          redirect_to root_path, notice: '退会が完了しました。'
        else
          redirect_to mypage_path, alert: '退会処理に失敗しました。'
        end
      end

      private

      def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password, :twitter, :instagram, :facebook, :tiktok)
      end
    end
  end
end