Rails.application.routes.draw do
  post '/rate' => 'rater#create', :as => 'rate'
  ActiveAdmin.routes(self)
  devise_for :users
  resources :cars
  resources :messages
  resources :profiles
  resources :orders
  resources :reviews
  resources :messages
  resources :messages

  get 'dashboard', to: 'orders#home', as: :dashboard
  get 'dashboard/trips/new', to: 'orders#new', as: :new_trip
  get 'dashboard/trips', to: 'orders#index', as: :trips
  get 'dashboard/trips/:id', to: 'orders#show', as: :trip

  get 'take_order/:id', to: 'orders#driver_take_order'
  get 'complete_order/:id', to: 'orders#complete_order'

  get 'take_position', to: 'orders#take_position'
  get 'find_coords', to: 'orders#find_coords'
  get 'find_place', to: 'orders#find_place'

  root to: 'visitors#index'
end
