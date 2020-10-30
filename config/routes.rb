Rails.application.routes.draw do
  root "posts#index"
  match '/users',   to: 'users#index',   via: 'get'
  match '/users/:id',     to: 'users#show',       via: 'get'

  devise_for :users, :controllers => {registrations: "registrations", omniauth_callbacks: 'users/omniauth_callbacks' }, :path_prefix => 'd'
  #devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }


  resources :users, :only =>[:show]
  resources :posts
  resources :friends, only: [:index, :create]
  
  resources :notifications do
    collection do
      post :mark_as_read
    end
  end

  resources :posts do
    resources :likes, :comments
  end
  
  post "/friends/accept" => "friends/accept"
  post "/friends/decline" => "friends/decline"
  post "/friends/remove" => "friends/remove"
  post "/friends/block" => "friends/block"
  post "/friends/unblock" => "friends/unblock"


 
  


end




#resources friends?