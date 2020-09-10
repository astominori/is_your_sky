Rails.application.routes.draw do
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"
  get "about" => "home#about"
  root 'home#index'
  resources :users
  resources :posts
end
