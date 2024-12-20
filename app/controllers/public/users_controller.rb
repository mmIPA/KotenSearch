class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit]
  before_action :correct_user, only: [:edit]
  before_action :ensure_guest_user, only: [:edit]

  def show
    @user = current_user
    @posts = @user.posts
    @liked_posts = Post.joins(:favorites).where(favorites: { user_id: @user.id })
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
    params.require(:user).permit(:name, :email, :twitter, :instagram, :facebook, :tiktok)
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end  
end
