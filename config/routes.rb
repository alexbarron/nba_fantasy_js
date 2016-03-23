Rails.application.routes.draw do
  resources :roster_spots, only: [:create, :destroy]

  resources :players

  resources :teams

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  root 'static#home'

end