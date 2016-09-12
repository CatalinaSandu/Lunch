Rails.application.routes.draw do
  resources :orders
  resources :menus
  root 'menus#index'


end
