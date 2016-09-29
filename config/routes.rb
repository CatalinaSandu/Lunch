Rails.application.routes.draw do

  resources :orders
  resources :dishes
  resources :menus
  resources :restaurants
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, :controllers => { :registrations => "register", omniauth_callbacks: 'omniauth_callbacks' }
  resources :users

  root 'menus#index'

  mount API::Base => "/"
  mount GrapeSwaggerRails::Engine, at: "/swagger"

  get '/application/refresh_dish_selection', as: 'refresh_dish_selection'

end
