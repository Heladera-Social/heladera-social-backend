HeladeraSocialBackend::Application.routes.draw do

  get 'storage_unit/show'
  get 'storage_unit/index'
  devise_for :users, :controllers => { :registrations => "users/registrations" }
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: 'application#index'

  require 'sidekiq/web'
  mount Sidekiq::Web, at: 'sidekiq'
  mount PgHero::Engine, at: 'pghero'
end
