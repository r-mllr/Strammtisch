# frozen_string_literal: true

Rails.application.routes.draw do
 
  namespace :admin do
    resources :users
    resources :events

    root to: 'users#index'
  end
  devise_for :users
  get 'pages/home'

  
  resources :events, except: [:destroy]


  root to: 'pages#home'
end
