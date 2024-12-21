module AdminPanel
  class PostsController < ApplicationController
    layout 'admin'
    
    before_action :authenticate_admin!
    before_action :set_post, only: [:show, :destroy]

    def show
    end
    
    def destroy
      if @post.destroy
        redirect_to admin_panel_user_path(@post.user), notice: '投稿が削除されました。'
      else
        redirect_to admin_panel_post_path(@post), alert: '投稿の削除に失敗しました。'
      end
    end

    private

    def set_post
      @post = Post.find(params[:id])
    end
  end
end