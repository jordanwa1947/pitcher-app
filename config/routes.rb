Rails.application.routes.draw do
  get 'logout', to: 'sessions#destroy'
  get 'auth/google_oauth2/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get '/', to: 'home#show'
  get 'dashboard', to: 'dashboard#show'

  get 'images', to: 'images#index'

  root to: "home#show"
end
