Rails.application.routes.draw do
  root "main#index"
  resources :cards
  resources :reviews, only: [:new, :create]
end
