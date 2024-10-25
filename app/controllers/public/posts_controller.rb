class Public::PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy] 
  before_action :restrict_guest_user, only: [:new, :create]
  before_action :set_categories
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

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
  
  def search
    query = params[:word]
    if query.present?
      @posts = Post.joins(:user)
                   .where('users.name LIKE ? OR posts.title LIKE ? OR posts.description LIKE ?', "%#{query}%", "%#{query}%", "%#{query}%")
                   .distinct
    else
      @posts = Post.all
    end
    render :index
  end

  def show
  end

  def edit
  end
  
  def update
    if @post.update(post_params)
      redirect_to @post, notice: '投稿が更新されました。'
    else
      render :edit
    end 
  end
  
  def destroy
    if @post.user_id == current_user.id
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
  
  def restrict_guest_user
    if current_user.guest_user?
      redirect_to posts_path, alert: 'ゲストユーザーは投稿できません。'
    end
  end
  
  def set_post
    @post = Post.find_by(id: params[:id])
    unless @post
      redirect_to posts_path, alert: '指定された投稿は見つかりませんでした。'
    end
  end
  
  def set_categories
    @categories = Category.all
  end

  def correct_user
    unless @post.user_id == current_user.id
      redirect_to posts_path, alert: '他のユーザーの投稿を編集する権限がありません。'
    end
  end
end

