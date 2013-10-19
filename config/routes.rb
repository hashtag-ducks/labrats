Labrats::Application.routes.draw do
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :notebooks

  root to: 'static_pages/#home'

  match '/signup', to: 'users#new'
  match '/signin', to: 'sessions#new'
  match '/signout', to: 'sessions#destroy'#, via: :delete
end
