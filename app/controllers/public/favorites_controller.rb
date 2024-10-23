class Public::FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :guest_user_restriction, only: [:create, :destroy]

  def create
    @post = Post.find(params[:post_id])
    unless @post.favorited_by?(current_user)
      @post.favorites.create(user: current_user)
    end
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = @post.favorites.find_by(user: current_user)
    favorite&.destroy
    respond_to do |format|
      format.js
    end
  end
  
  def show
    @user = current_user
    @posts = @user.posts
    @liked_posts = @user.favorites.map(&:post)
  end
  
  private

  def guest_user_restriction
    if current_user.guest_user?
      redirect_to root_path, alert: 'ゲストユーザーはいいね機能を利用できません。'
    end
  end
  
end
