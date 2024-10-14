class Public::CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_post

    def create
      @comment = @post.comments.new(comment_params)
      @comment.user = current_user
      if @comment.save
        redirect_to @post, notice: 'コメントを投稿しました。'
      else
        redirect_to @post, alert: 'コメント投稿に失敗しました。'
      end
    end

    def destroy
      @comment = @post.comments.find(params[:id])
      if @comment.user == current_user
        @comment.destroy
        redirect_to @post, notice: 'コメントを削除しました。'
      else
        redirect_to @post, alert: '自分のコメントのみ削除できます。'
      end
    end

    private

    def set_post
      @post = Post.find(params[:post_id])
    end

    def comment_params
      params.require(:comment).permit(:content)
    end
end