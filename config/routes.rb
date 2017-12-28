Rails.application.routes.draw do
  resources :user_artists
  resources :artists
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'application#welcome'
  
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  
  get '/welcome' => 'application#welcome'
  
  resources :users, :only => [:show]
end
