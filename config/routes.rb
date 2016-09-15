Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  resources :users
  resources :orders
  resources :menus

  root 'menus#index'

  mount API::Base => "/"
  mount GrapeSwaggerRails::Engine, at: "/documentation"


end
