Rails.application.routes.draw do
  devise_for :users

  resources :offers do
    resources :reservations, only: %i[new create]
  end
  resources :reservations, only: %i[index destroy edit update]

  root to: "pages#home"
end
