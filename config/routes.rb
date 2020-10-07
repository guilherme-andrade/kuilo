# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'static#home'
  devise_for :users

  resources :organizations do
    resources :enterprises
    resources :organization_members, path: 'members'
  end

  resources :enterprises do
    resources :properties, module: 'enterprises'
  end

  resources :properties do
    resources :contracts, module: 'properties'

    collection do
      get 'apartments', to: 'properties/apartments#index'
      get 'warehouses', to: 'properties/warehouses#index'
      get 'houses', to: 'properties/houses#index'
      get 'offices', to: 'properties/offices#index'
      get 'rooms', to: 'properties/rooms#index'
      get 'garages', to: 'properties/garages#index'
    end
  end

  resources :contracts do
    resources :rents
  end

  resources :rents
  resources :contracts
end
