Rails.application.routes.draw do
  namespace :admin do
    resources :locations
    resources :rounds

    root to: "locations#index"
  end

  get 'home/index'

  root to: 'home#index'

  get 'home/index'

  resources :locations

  resources :rounds

  resources :batches

end
