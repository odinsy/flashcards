Rails.application.routes.draw do

  root "main#index"
  resources :cards
  resources :reviews, only: [:new, :create]
  # UsersController
  resources :users, only: [:new, :create, :show, :edit, :update]
  get "/sign_up", to: "users#new", as: :sign_up
  # SessionsController
  resources :sessions, only: [:new, :create, :destroy]
  get "/login", to: "sessions#new", as: :login
  delete "/logout", to: "sessions#destroy", as: :logout
  # OAuthController
  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback" # for use with Github, Facebook
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider

end
