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

  get 'account/show'

  get 'account', to: 'account#show'

  get 'account/edit'

  patch 'account', to: 'account#update'

  get  '/login',  to: 'sessions#new'
  get  '/logout', to: 'sessions#destroy'
  get  '/signup', to: 'users#new'

end
