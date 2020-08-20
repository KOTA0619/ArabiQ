Rails.application.routes.draw do
  root to: 'toppages#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'withdrawl', to: 'users#destroy_confirmation'
    
  resources :users do
    resources :notifications, only: [:index]
    get 'favorite_questions', to: 'favorites#index'
  end
  
  
  resources :questions, only: [:show, :new, :create, :edit, :update, :destroy] do
    resources :answers, only: [:new, :create, :edit, :update, :destroy]
    get :search, on: :collection
    post 'like', to: 'favorites#create'
    delete 'dislike', to: 'favorites#destroy'
  end
  
  resources :acount_activations, only: [:edit]
  
  

end
