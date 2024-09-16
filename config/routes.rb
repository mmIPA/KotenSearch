Rails.application.routes.draw do
  devise_for :users, controllers: {  registrations: 'users/registrations'}
  resources :users, only: [:show, :edit]
  
  get 'posts/new'
  get 'posts/index'
  get 'posts/show'
  get 'posts/edit'
  get "/" => "homes#top"
end