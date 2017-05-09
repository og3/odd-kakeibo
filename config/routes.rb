Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show] do
    resources :treasurers, only: [:index, :create, :destroy, :edit]
  end
  root 'users#show'
end
