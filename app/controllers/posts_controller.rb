class PostsController < ApplicationController
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to mypage_path, notice: '投稿しました。'
    else
      render :new
    end
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
  end
  
  def destroy
    if @post.user == current_user
      @post.destroy
      redirect_to mypage_path, notice: '投稿を削除しました。'
    else
      redirect_to posts_path, alert: '投稿を削除する権限がありません。'
    end  
  end
  
  private

  def post_params
    params.require(:post).permit(:title, :description, :start_date, :end_date, :start_time, :end_time, :place, :image)
  end
  
end
