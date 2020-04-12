Rails.application.routes.draw do
  root "products#index"
  resources :products, only: [:create, :index, :show]
end
