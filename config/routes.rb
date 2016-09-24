HeladeraSocialBackend::Application.routes.draw do

  devise_for :users, :controllers => { :registrations => "users/registrations" }
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: 'application#index'

  require 'sidekiq/web'
  mount Sidekiq::Web, at: 'sidekiq'
  mount PgHero::Engine, at: 'pghero'

  resources :storage_units, only: [:index, :show, :edit, :update] do
    collection do
      get :favorites
    end
    member do
      post :favorite
      delete :unfavorite
    end
  end

  resources :donations, only: [:create, :new, :show]
  resources :extractions, only: [:create, :new, :show]
end
