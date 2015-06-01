Rails.application.routes.draw do

  root 'mkdev#index'

  resources :cards

end
