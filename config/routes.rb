Rails.application.routes.draw do
  resources :cars
  ActiveAdmin.routes(self)
  devise_for :users
  resources :messages
  resources :profiles
  resources :orders
  resources :reviews
  resources :messages
  resources :messages
  root to: 'visitors#index'

  post 'help_request', to: 'application#help_request'

  get '/dashboard', to: 'gmaps#rider_dashboard' # !!!change link

  get '/take_position', to: 'gmaps#take_position'
  get '/find_coords', to: 'gmaps#find_coords'
  get '/find_place', to: 'gmaps#find_place'
end
