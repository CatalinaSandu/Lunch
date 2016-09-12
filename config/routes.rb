Rails.application.routes.draw do
  devise_for :users
  resources :orders
  resources :menus
  root 'menus#index'


end
