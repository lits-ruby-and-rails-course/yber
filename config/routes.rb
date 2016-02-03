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

  get 'dashboard', to: 'orders#home', as: :dashboard
  get 'dashboard/trips/new', to: 'orders#new', as: :new_trip
  #post 'dashboard', to: 'orders#create'
  get 'dashboard/trips', to: 'orders#index', as: :trips
  #delete 'dashboard/trips/destroy', to: 'orders#destroy'
  get 'dashboard/trips/:id', to: 'orders#show', as: :trip

  get 'take_position', to: 'orders#take_position'
  get 'find_coords', to: 'orders#find_coords'
  get 'find_place', to: 'orders#find_place'

  root to: 'visitors#index'
end
