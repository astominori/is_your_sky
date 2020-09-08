Rails.application.routes.draw do
  get 'posts/index'
  get 'posts/new'
  get 'sessions/create'
  get 'sessions/destroy'
  root 'home#index'
  resources :users
end
