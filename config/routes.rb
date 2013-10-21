Labrats::Application.routes.draw do
  resources :users do
    resources :notebooks, shallow: true do
      resources :pages, shallow: true do
        resources :tab_groups, shallow: true do
          resources :boxes, shallow: true
        end
      end
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  # resources :notebooks, only: [:destroy, :show, :]
  # resources :pages
  # resources :tab_groups

  root to: 'static_pages/#home'

  match '/signup', to: 'users#new'
  match '/signin', to: 'sessions#new'
  match '/signout', to: 'sessions#destroy'#, via: :delete
end
