Rails.application.routes.draw do
  get 'answer_replies/new/:id', to: 'answer_replies#new', as: 'new_reply'
  post 'answer_replies', to: 'answer_replies#create'
  
  get 'answers/new/:id', to: 'answers#new', as: 'new_answer'
  post 'answers', to: 'answers#create'
  
  get 'questions/new'
  get 'questions/index', to: 'questions#index', as: 'questions_index'
  get 'questions/index/:id', to: 'questions#user_questions_index',\
    as: 'user_questions_index'
  post 'questions', to: 'questions#create'
  get 'questions/:id', to: 'questions#show', as: 'question'
  get 'questions/edit/:id', to: 'questions#edit', as: 'edit_question'
  patch 'questions/:id', to: 'questions#update'
  get 'questions/confirm_delete_question/:id', to: 'questions#confirm_deletion',\
    as: 'confirm_delete_question'
  delete 'questions/destroy/:id', to: 'questions#destroy', as: 'destroy_question'
  
  get 'users/resign', to: 'users#resign', as: 'resign_user'
  resources 'users'
  
  root 'pages#index'
  get 'pages/index'
  get 'pages/help_index'
  
  get 'home', to: 'users#home'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
