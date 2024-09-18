Rails.application.routes.draw do
  devise_for :users, controllers: {  registrations: 'users/registrations'}
  get '/mypage', to: 'users#show', as: 'mypage'
  resources :users, only: [:edit]
  
  get 'posts/new'
  get 'posts/index'
  get 'posts/show'
  get 'posts/edit'
  get "/" => "homes#top"
end