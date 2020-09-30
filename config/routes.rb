Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: "omniauth_callbacks",
    sessions: 'users/sessions'
   }
  root 'home#index'
  get "about", to: "home#about"
  get "/mypages", to: "mypages#show", as: :user_root
  get "todays_posts",to: "posts#todays_posts"
  get "this_months_posts", to: "posts#this_months_posts"
  resources :posts
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
