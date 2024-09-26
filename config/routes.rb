Rails.application.routes.draw do

scope module: :public do
  devise_for :users, controllers: {  registrations: 'users/registrations'}
  get '/mypage', to: 'users#show', as: 'mypage'
  resources :users, only: [:edit]
  resources :posts
  root "homes#top"
end
  
  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }
   
  namespace :admin do
    get 'dashboards', to: 'dashboards#index'
    resources :users, only: [:destroy]
    resources :categories, only: [:index, :new, :create, :destroy]
  end
end