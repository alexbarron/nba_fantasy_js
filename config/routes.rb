Rails.application.routes.draw do
  resources :teams

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  root 'static#home'

end