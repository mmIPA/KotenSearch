Rails.application.routes.draw do
  devise_for :users
  get 'posts/new'
  get 'posts/index'
  get 'posts/show'
  get 'posts/edit'
  get "/" => "homes#top"
end