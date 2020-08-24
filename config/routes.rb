Rails.application.routes.draw do
  devise_for :users
  root 'items#index'

  resources :sells, only: [:index,:create] do
    collection do
      get :search
    end
  end

  resources :categories, only: [:index] do
    member do
      get 'parent'
      get 'child'
      get 'grandchild'
    end
  end
  root to: 'items#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  devise_scope :user do
    get 'streets', to: 'users/registrations#new_streets'
    post 'streets', to: 'users/registrations#create_streets'
  end
  resources :items, only: [:index,:show, :destroy] do
    resource :purchases, only: [:show, :update]    
  end
  resources :credits, only: [:index, :show, :new, :create, :destroy]
end
