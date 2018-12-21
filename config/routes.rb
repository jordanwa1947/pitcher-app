Rails.application.routes.draw do
  get 'logout', to: 'sessions#destroy'
  get 'auth/google_oauth2/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get '/', to: 'home#show'
  get 'dashboard', to: 'dashboard#show'
  get 'images', to: 'images#index'
  delete 'images', to: 'images#destroy', as: 'dislike'
  get 'matches', to: 'matches#index'
  post 'matches', to: 'matches#create', as: 'like'

  root to: "home#show"

  get '/wishlist', to: 'wishlist#index', as: 'wishlist'

  resources :users do
    resources :main_addresses, only: [:create, :destroy, :edit, :update]
  end
end
