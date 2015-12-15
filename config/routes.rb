Rails.application.routes.draw do
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :messages
  resources :profiles
  resources :orders
  resources :reviews
  resources :messages
  resources :messages
  root to: 'visitors#index'
end
