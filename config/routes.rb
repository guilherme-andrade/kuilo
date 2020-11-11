# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resources :enterprises do
    scope module: 'enterprises' do
      resources :properties, only: %i[new create]
    end
  end

  resource :profile, only: %i[show update]

  scope module: 'organizations', path: '/organizations' do
    resource :sessions, as: :organization_session, only: %i[create new destroy]
    resource :current, as: :current_organization, only: %i[show edit update destroy] do
      scope module: :currents do
        resources :members
      end
    end
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
