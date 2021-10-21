Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  root 'categories#index'

  resources :users
  resources :categories
  resources :posts
end
