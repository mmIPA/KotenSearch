class Public::PostsController < ApplicationController
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
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post, notice: '投稿が更新されました。'
    else
      render :edit
    end 
  end
  
  def destroy
    @post = Post.find(params[:id]) 
    if @post.user == current_user
      @post.destroy
      redirect_to mypage_path, notice: '投稿を削除しました。'
    else
      redirect_to posts_path, alert: '投稿を削除する権限がありません。'
    end  
  end
  
  private

  def post_params
    params.require(:post).permit(:title, :description, :start_date, :end_date, :start_time, :end_time, :place, :image, category_ids: [])
  end
  
  def set_post
    @post = Post.find_by(id: params[:id])
    unless @post
      redirect_to posts_path, alert: '指定された投稿は見つかりませんでした。'
    end
  end
end
