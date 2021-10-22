Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  root 'categories#index'

  resources :users, only: %i[show] do
    resources :posts, only: %i[show]
  end

  resources :categories, only: %i[index show] do
    resources :posts, only: %i[show]
  end
end
