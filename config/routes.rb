Rails.application.routes.draw do
  devise_for :users

  resources :offers do
    resources :reservations, only: %i[new create edit update]
  end
  resources :reservations, only: %i[index destroy]

  root to: "offers#index"
end
