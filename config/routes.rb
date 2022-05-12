# frozen_string_literal: true

Rails.application.routes.draw do
  resources :posts do
    resources :comments
  end

  post 'posts/:id/like', to: 'likes#postlike', as: 'post_like'
  post 'posts/:id/comment/:cid/like', to: 'likes#commentlike', as: 'comment_like'
  get 'users/index', to: 'users#index', as: 'users'
  get 'users/:id/profile', to: 'users#show', as: 'user'
  get 'search', to: 'users#index'

  post 'users/:id/follow', to: 'users#follow', as: 'follow_user'
  post 'users/:id/unfollow', to: 'users#unfollow', as: 'unfollow_user'
  resources :stories
  devise_for :users
  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
