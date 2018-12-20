Rails.application.routes.draw do
  get 'logout', to: 'sessions#destroy'
  get 'auth/google_oauth2/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get '/', to: 'home#show'
  get 'dashboard', to: 'dashboard#show'

  root to: "home#show"

  get '/wishlist', to: 'wishlist#index', as: 'wishlist'

  resources :users do
    resources :main_addresses, only: [:create, :destroy]
  end
end
