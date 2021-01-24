Rails.application.routes.draw do
  # root route
  get "/" => "home#index"
  # menu routes
  resources :menus

  get "/manage/menus" => "menus#show_all", as: :all_menus
  post "/manage/menus/:id" => "menus#menuitem_additem"
  get "/menuitem/:id" => "menus#menuitem_edit"
  put "/menuitem/:id" => "menus#menuitem_update"
  delete "menuitem/:id" => "menus#menuitem_delete"

  # user routes
  resources :users

  post "/users/clerk" => "users#clerk_create", as: :clerks

  resources :carts

  get "/orders" => "orders#index", as: :all_orders
  post "/orders" => "orders#create", as: :orders
  get "/orders/:id" => "orders#show"

  get "/signin" => "sessions#new", as: :new_session
  post "/signin" => "sessions#create", as: :sessions
  delete "/signout" => "sessions#destroy", as: :destroy_session
end
