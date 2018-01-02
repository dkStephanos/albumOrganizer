Rails.application.routes.draw do
  resources :genres
  resources :songs
  resources :albums
  resources :artists
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'application#welcome'
  
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  
  get '/welcome' => 'application#welcome'
  
  resources :users, :only => [:show]
  
  resources :artists do
    resources :albums, :only => [:index, :show, :new, :edit]
  end
  
  resources :albums do
    resources :songs, :only => [:index, :show, :new, :edit]
  end
end
