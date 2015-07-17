Rails.application.routes.draw do

  root "main#index"
  resources :cards
  resources :reviews, only: [:new, :create]
  # Registrations
  resources :registrations, only: [:new, :create]
  # Profile
  resources :profile, only: [:edit, :show, :update]
  # Sessions
  resources :sessions, only: [:new, :create, :destroy]
  get "/login", to: "sessions#new", as: :login
  delete "/logout", to: "sessions#destroy", as: :logout
  # OAuth
  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback" # for use with Github, Facebook
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider

end
