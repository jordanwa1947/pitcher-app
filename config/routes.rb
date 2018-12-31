Rails.application.routes.draw do
  get 'logout', to: 'sessions#destroy'
  get 'auth/google_oauth2/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get '/', to: 'home#show'
  get 'dashboard', to: 'dashboard#show'
  get 'matches', to: 'matches#index'
  post 'matches', to: 'matches#create', as: 'like'
  delete 'matches', to: 'matches#destroy', as: 'dislike'
  patch 'matches', to: 'matches#update', as: 'finish'

  root to: "home#show"

  get '/wishlist', to: 'wishlist#index', as: 'wishlist'
  delete '/wishlist/:id', to: 'wishlist#destroy'

  post '/visited/:id', to: 'visits#create'
  get '/visited', to: 'visits#index'


  resources :users do
    resources :main_addresses, only: [:create, :destroy, :edit, :update]
  end

  resources :restaurants, only: [:show] do
    resources :reviews, only: [:create]
  end

  get '/directions/:id', to: 'directions#show'
end
