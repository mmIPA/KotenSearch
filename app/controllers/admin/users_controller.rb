class Admin::UsersController < ApplicationController
    before_action :authenticate_admin!
    before_action :set_user, only: [:show, :destroy]

    def index
      @users = User.all
    end
    
    def show
    end

    def destroy
        @user = User.find(params[:id])
        @user.destroy
        redirect_to admin_users_path, notice: 'ユーザーを削除しました。'
    end
    
    private

    def set_user
      @user = User.find(params[:id])
    end
    
end