Rails.application.routes.draw do
  devise_for :users, controllers: {  registrations: 'users/registrations'}
  get '/mypage', to: 'users#show', as: 'mypage'
  resources :users, only: [:edit]
  resources :posts, only: [:new, :create, :show, :index]
  root "homes#top"
end