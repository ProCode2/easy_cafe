Rails.application.routes.draw do
  # root route
  get "/" => "home#index"
  # menu routes
  resources :menus

  get "/manage/menus" => "menus#show_all", as: :all_menus
  post "/manage/menus/:id" => "menu_items#create"
  get "/menuitem/:id" => "menu_items#edit"
  put "/menuitem/:id" => "menu_items#update"
  delete "menuitem/:id" => "menu_items#delete"

  # user routes
  resources :users

  post "/users/clerk" => "users#clerk_create", as: :clerks

  resources :carts

  get "/orders" => "orders#index", as: :all_orders
  post "/orders" => "orders#create", as: :orders
  get "/orders/:id" => "orders#show"
  put "/orders/:id" => "orders#update"
  get "/manage/orders" => "orders#show_all", as: :manage_orders

  get "/signin" => "sessions#new", as: :new_session
  post "/signin" => "sessions#create", as: :sessions
  delete "/signout" => "sessions#destroy", as: :destroy_session

  get "/report" => "reports#index", as: :reports
  get "/report/users" => "reports#user_orders"
  post "/report/users" => "reports#user_orders", as: :user_orders
end
