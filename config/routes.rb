Rails.application.routes.draw do
  resources :users
  resources :quests

  get 'searches/result'
  get 'starts/start_p'
  get 'ranking/rank_p'
  get 'mains/main'
  get 'logins/login'
  get 'mains/change_p'
  post 'login/sign_in', to: 'logins#create'
  post 'start/submit_answer', to: 'starts#submit_answer', as: 'submit_answer_start'

  root 'logins#login'

  delete 'main/sign_out', to: 'mains#destroy'
end