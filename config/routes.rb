Rails.application.routes.draw do
  # root route
  get "/" => "home#index"
  # menu routes
  resources :menus
  # user routes
  resources :users
end
