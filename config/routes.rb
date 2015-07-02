Rails.application.routes.draw do

  root "main#index"
  resources :cards do
    member do
      post "compare"
    end
  end

end
