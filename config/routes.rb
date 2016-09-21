Rails.application.routes.draw do

  resources :dishes
  resources :menus
  resources :restaurants
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, :controllers => { :registrations => "register" }
  resources :users
  resources :orders

  root 'menus#index'

  mount API::Base => "/"
  mount GrapeSwaggerRails::Engine, at: "/swagger"


end
