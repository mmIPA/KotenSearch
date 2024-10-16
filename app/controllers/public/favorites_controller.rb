class Public::FavoritesController < ApplicationController
  before_action :authenticate_user!

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
end
