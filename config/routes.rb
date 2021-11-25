# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  resources :sessions
  resources :blogs
  resources :blogs do
    resources :comments
  end
  resources :comments

  resources :users do
    resources :blogs
  end
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
  get '/signup' => 'users#new'
  post '/users' => 'users#create'
  root to: 'blogs#index'

  mount ActionCable.server => '/cable'
end
