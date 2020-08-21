Rails.application.routes.draw do
  devise_for :users
  root 'items#index'
  resources :sells, only: [:index,:create,:edit]
  resources :items, only: [:index,:show]
  resources :users, only: [:new,:create]
  resources :purchases, only: :index

  resources :sells do
    collection do
      get :search
    end
  end
end
