class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'ユーザー情報が更新されました。'
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def correct_user
    redirect_to(root_path) unless @user == current_user
  end

  def user_params
    params.require(:user).permit(:name, :email)
  end

end
