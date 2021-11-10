Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  
  devise_scope :user do
    get '/users/sign_up', to: 'devise/registrations#new'
    get '/users/sign_in', to: 'devise/sessions#new'
    get '/users/sign_out', to: 'devise/sessions#destroy'
    get '/users/:id', to: 'users#show', as: 'user'
    get '/users/:id/edit', to: 'users#edit', as: 'edit_user'
    get '/users/:id/make_admin', to: 'users#make_admin', as: 'make_user_an_admin'
    get '/users/:id/make_user', to: 'users#make_user', as: 'make_admin_an_user'
    get '/posts/:id/approve_post', to: 'posts#approve_post', as: 'approve_post'
    get '/posts/:id/decline_post', to: 'posts#decline_post', as: 'decline_post'
    get '/posts/:id/change_mind', to: 'posts#change_mind', as: 'change_mind'
  end

  devise_for :users

  root 'categories#index'

  resources :users, only: %i[show] do
    get '/users/:user_id/posts/:id/submit_post', to: 'posts#submit_post', as: 'submit_post'
    get '/users/:user_id/posts/:id/undo_submit', to: 'posts#undo_submit', as: 'undo_submit'
    resources :posts
  end

  resources :categories, only: %i[index show] do
    resources :posts, only: %i[show]
  end
end
