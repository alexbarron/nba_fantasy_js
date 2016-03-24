Rails.application.routes.draw do
  resources :leagues

  resources :roster_spots, only: [:create, :destroy, :update]

  resources :players

  resources :teams

  get '/efficient', to: 'teams#most_efficient'
  get '/valuable', to: 'players#most_valuable'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  root 'teams#index'

end