module AdminPanel
  class CategoriesController < ApplicationController
    layout 'admin'
    
    before_action :authenticate_admin!
    before_action :ensure_admin_user
  
  
    def index
      @categories = Category.all
    end
  
    def new
      @category = Category.new
    end
  
    def create
      @category = Category.new(category_params)
      if @category.save
        redirect_to admin_panel_categories_path, notice: 'カテゴリが作成されました。'
      else
        render :new
      end
    end
    
    def destroy
      @category = Category.find(params[:id])
      if @category.destroy
        redirect_to admin_panel_categories_path, notice: 'カテゴリが削除されました。'
      else
        redirect_to admin_panel_categories_path, alert: 'カテゴリの削除に失敗しました。'
      end
    end
    
    private
  
    def category_params
      params.require(:category).permit(:name)
    end
    
    def ensure_admin_user
      redirect_to root_path unless current_admin
    end
  end
end