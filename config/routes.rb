# frozen_string_literal: true

Rails.application.routes.draw do
  get 'profiles/show'
  devise_for :users

  resources :enterprises do
    scope module: 'enterprises' do
      resources :properties, only: %i[new create]
    end
  end

  resource :profile, only: %i[show update]

  scope module: 'organizations', path: '/organizations' do
    resource :sessions, as: :organization_session, only: %i[create new destroy]
    resource :current, as: :current_organization, only: %i[show edit update destroy]
    resources :enterprises, only: %i[new create], as: :organization_enterprises
  end

  resources :organizations, only: %i[new create]

  authenticated :user do
    get '/', to: 'organizations/sessions#new', as: :authenticated_root
  end

  root to: 'static#home'

  resources :properties do
    scope module: 'properties' do
      resources :contracts

      collection do
        get 'apartments', to: 'apartments#index'
        get 'warehouses', to: 'warehouses#index'
        get 'houses', to: 'houses#index'
        get 'offices', to: 'offices#index'
        get 'rooms', to: 'rooms#index'
        get 'garages', to: 'garages#index'
      end
    end
  end

  resources :contracts do
    resources :rents, only: %i[new create]
  end

  resources :rents, only: %i[edit destroy update show index]
  resources :contracts
end
