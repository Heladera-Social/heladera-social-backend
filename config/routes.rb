HeladeraSocialBackend::Application.routes.draw do

  devise_for :users, :controllers => { :registrations => "users/registrations" }
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: 'storage_units#index'

  require 'sidekiq/web'
  mount Sidekiq::Web, at: 'sidekiq'
  mount PgHero::Engine, at: 'pghero'

  resources :storage_units, only: [:index, :show, :edit, :update, :create, :new] do
    collection do
      get :favorites
      get :list
      get :map
    end
    member do
      get :product_types
      get :inventory
      post :favorite
      delete :unfavorite
    end
  end

  resources :bar_code do
    collection do
      get :get_product
    end
  end

  resources :donations, only: [:create, :new, :show] do
    collection do
      get :creation_info
    end
  end
  resources :extractions, only: [:create, :new, :show]
  resources :contacts, only: [:create, :new]
  resources :products, only: [:index]
end
