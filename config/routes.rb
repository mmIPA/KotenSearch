Rails.application.routes.draw do

scope module: :public do
  devise_for :users, controllers: { registrations: 'public/users/registrations' }
  get '/mypage', to: 'users#show', as: 'mypage'
  
  resources :posts do
    collection do
      get 'search'
    end
  end  

  #resources :users, only: [:edit]
  resources :posts
  resources :categories, only: [:index, :show]
  root "homes#top"
  end
  
  devise_scope :user do
    post "public/users/guest_sign_in", to: "public/users/sessions#guest_sign_in", as: :guest_sign_in
  end
  
  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }
   
  namespace :admin do
    #get 'dashboards', to: 'dashboards#index'
    resources :users, only: [:index, :destroy]
    resources :categories, only: [:index, :new, :create, :destroy]
  end
end