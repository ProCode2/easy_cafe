Rails.application.routes.draw do
  # root route
  get "/" => "home#index"
  # menu routes
  resources :menus
end
