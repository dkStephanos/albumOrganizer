Rails.application.routes.draw do
  resources :user_favorite_songs
  resources :genres
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'application#welcome'
  
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  
  get '/welcome' => 'application#welcome'
  get '/home' => 'users#home'
  get '/songs/last' => 'songs#last'
  get '/users/current' => 'users#current'
  get '/access_requests/approve' => 'access_requests#approve'
  get '/access_requests/new' => 'access_requests#new'
  
  resources :users, :only => [:show, :index]
  
  resources :albums do
    resources :songs do
      put :favorite, on: :member
    end
  end

  resources :artists do
    resources :albums, :only => [:show, :new, :edit]
  end
end
