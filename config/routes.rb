Rails.application.routes.draw do
  namespace :admin do
    resources :locations
    resources :rounds
    resources :batches
    resources :users

    root to: "locations#index"
  end

  root to: 'home#index'

  get 'home/index'

  resources :sessions, only: [:new, :create, :destroy]

  resources :locations

  resources :rounds

  resources :batches

  resources :users

end
