Rails.application.routes.draw do
  root to: 'toppages#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
    
  resources :users, only: [:index, :show, :new, :create]
  
  resources :questions, only: [:show, :new, :create] do
    resources :answers, only: [:new, :create]
  end
end
