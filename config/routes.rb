Rails.application.routes.draw do
  # root route
  get "/" => "home#index"
  # menu routes
  resources :menus
  # user routes
  resources :users

  get "/cart" => "carts#index", as: :carts
  post "/cart" => "carts#create", as: :new_cart

  get "/signin" => "sessions#new", as: :new_session
  post "/signin" => "sessions#create", as: :sessions
  delete "/signout" => "sessions#destroy", as: :destroy_session
end
