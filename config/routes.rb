Rails.application.routes.draw do
  devise_for :users

  resources :offers do
    resources :reservations, only: %i[new create]
  end
  resources :reservations, only: %i[index destroy edit update] do
    member do
      patch :accept, to: "reservations#accept", as: :accept
      patch :reject, to: "reservations#reject", as: :reject
    end
  end

  root to: "pages#home"
  get "profil", to: "pages#profil"
  get "profil/:id", to: "pages#profilshow", as: :show_profil

  resources :users, only: %i[edit update]
end
