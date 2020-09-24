Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: "omniauth_callbacks",
    sessions: 'users/sessions'
   }
  get "about", to: "home#about"
  root 'home#index'
  get "/mypages", to: "mypages#show", as: :user_root
  resources :posts
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
