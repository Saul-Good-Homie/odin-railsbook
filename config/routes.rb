Rails.application.routes.draw do
  match '/users',   to: 'users#index',   via: 'get'
  match '/users/:id',     to: 'users#show',       via: 'get'
  devise_for :users, :controllers => {registrations: "registrations"}, :path_prefix => 'd'
  resources :users, :only =>[:show]
  resources :posts
  resources :posts do
    resources :likes, :comments
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "posts#index"
end
