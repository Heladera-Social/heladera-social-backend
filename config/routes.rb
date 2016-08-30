HeladeraSocialBackend::Application.routes.draw do

  get 'storage_unit/show'
  devise_for :users, :controllers => { :registrations => "users/registrations" }
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: 'application#index'

  require 'sidekiq/web'
  mount Sidekiq::Web, at: 'sidekiq'
  mount PgHero::Engine, at: 'pghero'

  resources :storage_units, only: [:index, :show] do
    collection do
      get :favorites
    end
    member do
      post :favorite
      delete :unfavorite
    end
  end
end
