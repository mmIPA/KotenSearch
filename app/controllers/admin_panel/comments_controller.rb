module AdminPanel
  class CommentsController < ApplicationController
    layout 'admin'
    
    before_action :authenticate_admin!
  
    def index
      @comments = Comment.includes(:user, :post).all
    end

    def destroy
      @comment = Comment.find(params[:id])
      @comment.destroy
      redirect_to admin_panel_comments_path, notice: "コメントを削除しました。"
    end
  end
end