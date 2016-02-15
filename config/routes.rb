Rails.application.routes.draw do
  post '/rate' => 'rater#create', :as => 'rate'
    unless ARGV.grep(/assets:(precompile|clean)|db:(migrate)|c|console/).any?
      ActiveAdmin.routes(self)
    end
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

  post 'help_request', to: 'application#help_request'
  get 'take_order/:id', to: 'orders#driver_take_order'
  get 'complete_order/:id', to: 'orders#complete_order'

  get 'take_position', to: 'orders#take_position'
  get 'find_coords', to: 'orders#find_coords'
  get 'find_place', to: 'orders#find_place'
  
  get 'messages/new_message/:id', to: 'messages#new_message', as: :new_mes

  root to: 'visitors#index'
end
