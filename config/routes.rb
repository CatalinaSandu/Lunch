Rails.application.routes.draw do

  resources :orders
  resources :dishes
  resources :menus
  resources :restaurants
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  match '/auth/facebook/logout' => 'application#facebook_logout', :via => [:get], :as => :facebook_logout
  devise_for :users, :controllers => { :registrations => "register", omniauth_callbacks: 'users/omniauth_callbacks', sessions: 'users/sessions' }


  root 'menus#index'

  mount API::Base => "/"
  mount GrapeSwaggerRails::Engine, at: "/swagger"

  get '/application/refresh_dish_selection', as: 'refresh_dish_selection'

end
