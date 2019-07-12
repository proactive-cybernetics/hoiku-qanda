Rails.application.routes.draw do
  get 'answers/new/:id', to: 'answers#new', as: 'new_answer'
  post 'answers', to: 'answers#create'
  
  get 'questions/new'
  get 'questions/index', to: 'questions#index', as: 'questions_index'
  get 'questions/index/:id', to: 'questions#user_questions_index', as: 'user_questions_index'
  post 'questions', to: 'questions#create'
  get 'questions/:id', to: 'questions#show', as: 'question'
  get 'questions/edit/:id', to: 'questions#edit', as: 'edit_question'
  patch 'questions/:id', to: 'questions#update'
  
  resources 'users'
  
  root 'pages#index'
  get 'pages/index'
  get 'pages/help_index'
  
  get 'home', to: 'users#home'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
