Rails.application.routes.draw do
  namespace :admin do
    DashboardManifest::DASHBOARDS.each do |dashboard_resource|
      resources dashboard_resource
    end
    root controller: DashboardManifest::ROOT_DASHBOARD, action: :index
  end
  root to: 'visitors#index'
  devise_for :users

  get '/dashboard', to: 'gmaps#dashboard'

  get '/take_position', to: 'gmaps#take_position' 
  get '/find_place', to: 'gmaps#find_place' 
end
