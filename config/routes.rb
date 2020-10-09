# frozen_string_literal: true

Rails.application.routes.draw do
  get 'profiles/show'
  devise_for :users
  notify_to :users, with_subscription: true, with_devise: :users, devise_default_routes: true
  subscribed_by :users, with_devise: :users, devise_default_routes: true

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

  resources :rents, only: %i[destroy show index edit update] do
    resource :invoice, only: :show, module: 'rents'
  end

  resources :contracts
end
