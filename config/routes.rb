# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'static#home'
  devise_for :users

  resources :organizations do
    scope module: 'organizations' do
      resources :enterprises, only: %i[new create]
      resources :organization_members, path: 'members'
    end
  end

  scope module: 'organizations', path: '/organizations' do
    post '/sessions', to: 'sessions#create', as: :organization_session
    get '/sessions/new', to: 'sessions#new', as: :new_organization_session
    delete '/sessions', to: 'sessions#new', as: :destroy_organization_session
  end

  resources :enterprises do
    scope module: 'enterprises' do
      resources :properties, only: %i[new create]
    end
  end

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
