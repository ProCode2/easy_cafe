Rails.application.routes.draw do
  # root route
  get "/" => "home#index"
  # menu routes
  resources :menus
  # user routes
  resources :users
  resources :carts

  get "/orders" => "orders#index", as: :all_orders
  post "/orders" => "orders#create", as: :orders
  get "/orders/:id" => "orders#show"

  get "/signin" => "sessions#new", as: :new_session
  post "/signin" => "sessions#create", as: :sessions
  delete "/signout" => "sessions#destroy", as: :destroy_session
end
