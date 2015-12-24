Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users
  resources :cars
  resources :messages
  resources :profiles
  resources :orders
  resources :reviews
  resources :messages
  resources :messages
  root to: 'visitors#index'

  get '/dashboard', to: 'gmaps#dashboard'
  get '/take_position', to: 'gmaps#take_position'
  get '/find_place', to: 'gmaps#find_place'
end
