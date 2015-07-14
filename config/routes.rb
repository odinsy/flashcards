Rails.application.routes.draw do
  root "main#index"
  resources :cards
  resources :reviews, only: [:new, :create]
  resources :users, only: [:new, :create, :show, :edit, :update]
  get "/sign_up", to: "users#new", as: :sign_up
  resources :sessions, only: [:new, :create, :destroy]
  get "/login", to: "sessions#new", as: :login
  delete "/logout", to: "sessions#destroy", as: :logout
end
