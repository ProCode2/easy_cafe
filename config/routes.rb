Rails.application.routes.draw do
  # root route
  get "/" => "home#index"
  # menu routes
  resources :menus
  # user routes
  resources :users
  resources :carts

  post "/order" => "orders#create", as: :orders

  get "/signin" => "sessions#new", as: :new_session
  post "/signin" => "sessions#create", as: :sessions
  delete "/signout" => "sessions#destroy", as: :destroy_session
end
