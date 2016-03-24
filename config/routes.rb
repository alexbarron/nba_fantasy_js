Rails.application.routes.draw do
  
  resources :leagues
  resources :leagues, only: [:show] do
    resources :teams, only: [:show, :index, :new]
  end

  resources :roster_spots, only: [:create, :destroy, :update]

  resources :players

  resources :teams

  get '/efficient', to: 'teams#most_efficient'
  get '/valuable', to: 'players#most_valuable'
  post '/join_league', to: 'teams#join_league'
  post '/leave_league', to: 'teams#leave_league'
  post '/update_all_players', to: 'players#update_all'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  root 'teams#index'

end