require 'sidekiq/web'
Rails.application.routes.draw do
  root "products#index"
  resources :products, only: [:create, :index, :show]

  mount Sidekiq::Web => '/sidekiq'
end
