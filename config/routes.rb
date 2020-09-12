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

    resources :events
    resources :members
    resources :teams
    resources :service_apps, only: [:index, :create, :destroy]
  end

  namespace :api do
    namespace :v1 do
      post 'sign_in', to: 'sessions#create'
      post 'sign_out', to: 'sessions#destroy'

      resources :members, only: [:index, :show]
    end
  end
end
