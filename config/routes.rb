Rails.application.routes.draw do
  get 'questions/new'
  get 'questions/index'
  post 'questions', to: 'questions#create'
  get 'questions/:id', to: 'questions#show'
  
  resources 'users'
  root 'pages#index'
  
  get 'pages/index'
  get 'pages/help_index'
  
  get 'home', to: 'users#home'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
