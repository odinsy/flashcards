Rails.application.routes.draw do

  root "main#index"
  resources :cards, shallow: true do
    member do
      resources :reviews, only: [:new, :create]
    end
  end

end
