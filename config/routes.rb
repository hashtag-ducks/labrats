Labrats::Application.routes.draw do
  # Match these first, since Backbone doesn't deal with nested
  # resources well
  match 'notebooks/:notebook_id/page_templates/:id', to: 'page_templates#destroy', via: :delete
  match 'page_templates/:page_template_id/tab_group_templates/:id', to: 'tab_group_templates#destroy', via: :delete
  match 'tab_group_templates/:box_template_id/box_templates/:id', to: 'box_templates#destroy', via: :delete

  # For file uploads
  match 'boxes/:id/files', to: 'boxes#upload_file', via: :post

  resources :users do
    resources :notebooks, shallow: true do
      resources :page_templates, shallow: true do
        resources :tab_group_templates, shallow: true do
          resources :box_templates, shallow: true
        end
      end
      resources :pages, only: :show, shallow: true do
        resources :tab_groups, only: :show, shallow: true do
          resources :boxes, only: [:show, :update], shallow: true
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
