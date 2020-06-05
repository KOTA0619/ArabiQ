Rails.application.routes.draw do
  
  root to: 'toppages#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'withdrawl', to: 'users#destroy_confirmation'
    
  resources :users do
    resources :notifications, only: [:index]
  end
  
  
  resources :questions, only: [:show, :new, :create, :edit, :update, :destroy] do
    resources :answers, only: [:new, :create, :edit, :update, :destroy]
    get :search, on: :collection
  end
end
