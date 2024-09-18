class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def show
  end
  
  def edit
  end
  
  private

  def set_user
    @user = params[:id] ? User.find(params[:id]) : current_user
  end

  def correct_user
    redirect_to(root_path) unless @user == current_user
  end

  def user_params
    params.require(:user).permit(:name, :email)
  end

end
