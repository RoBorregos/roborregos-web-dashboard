Rails.application.routes.draw do
  devise_for :members, path: ''

  devise_scope :member do
    get 'sign_in', to: 'devise/sessions#new'
    get 'sign_out', to: 'devise/sessions#destroy'

    unauthenticated :member do
      root to: 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  authenticate :member do
    root to: 'members#index', as: :authenticated_root
    
    resources :categories, except: [:edit, :update]
    resources :components
    resources :component_categories
    resources :events
    resources :members
    resources :reservations, only: [:index]
    resources :teams
    resources :service_apps, only: [:index, :create, :destroy]
  end

  namespace :api do
    namespace :v1 do
      post 'sign_in', to: 'sessions#create'
      post 'sign_out', to: 'sessions#destroy'
      post 'join_request', to: 'mails#join_request' 

      resources :components, only: [:index, :show, :create, :update, :destroy]
      resources :component_categories, only: [:index, :show, :create, :destroy]
      resources :events, only: [:index, :show, :create, :destroy]
      resources :members, only: [:index, :show]
      resources :projects, only: [:index, :show, :create, :destroy]
      resources :reservations, only: [:index, :create, :show, :update]
      resources :sponsors, only: [:index, :show, :create, :destroy]
    end
  end
end
