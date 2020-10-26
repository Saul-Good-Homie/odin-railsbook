Rails.application.routes.draw do
  root "posts#index"
  match '/users',   to: 'users#index',   via: 'get'
  match '/users/:id',     to: 'users#show',       via: 'get'

  devise_for :users, :controllers => {registrations: "registrations"}, :path_prefix => 'd'
  
  resources :users, :only =>[:show]
  resources :posts
  resources :notifications

  resources :posts do
    resources :likes, :comments
  end
  
  post "/friends/accept" => "friends/accept"
  post "/friends/decline" => "friends/decline"
  post "/friends/remove" => "friends/remove"
  post "/friends/block" => "friends/block"
  post "/friends/unblock" => "friends/unblock"


  resources :friends, only: [:index, :create]
  


end




#resources friends?