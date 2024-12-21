Rails.application.routes.draw do

  scope module: :public do
    devise_for :users, controllers: { registrations: 'public/users/registrations',passwords: 'public/passwords' }
    get '/mypage', to: 'users#show', as: 'mypage'
    get "users" => redirect("/users/sign_up")
    
    resources :posts do
      collection do
        get 'search'
      end
      resources :comments, only: [:create, :destroy]
      resource :favorite, only: [:create, :destroy]
    end  
  
    resources :categories, only: [:index, :show]
    
    root "homes#top"
  end
  
  devise_scope :user do
    post "public/users/guest_sign_in", to: "public/users/sessions#guest_sign_in", as: :guest_sign_in
  end
  
  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin_panel/sessions'
  }
   
  namespace :admin_panel do
    resources :users, only: [:index, :show, :destroy]
    resources :posts, only: [:show]
    resources :categories, only: [:index, :new, :create, :destroy]
    resources :comments, only: [:index, :destroy] 
  end
end