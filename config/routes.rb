Labrats::Application.routes.draw do
  # Match these first, since Backbone doesn't deal with nested
  # resources well
  match 'notebooks/:notebook_id/pages/:id', to: 'pages#destroy', via: :delete
  match 'pages/:page_id/tab_groups/:id', to: 'tab_groups#destroy', via: :delete
  match 'tab_groups/:box_id/boxes/:id', to: 'boxes#destroy', via: :delete

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
  resources :notebook_access, only: [:create, :destroy]

  root to: 'static_pages#home'

  match '/signup', to: 'users#new'
  match '/signin', to: 'sessions#new'
  match '/signout', to: 'sessions#destroy'#, via: :delete
end
