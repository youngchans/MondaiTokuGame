Rails.application.routes.draw do
  get 'que/index'
  get 'que/edit'
  get 'que/update'
  get 'que/destroy'

  get 'ques/ques_p'
  get 'start/start_p'

  get 'ranking/rank_p'
  get 'mains/main'

  resources :users
  resources :que
  get 'logins/login'

  post 'login/sign_in', to: 'logins#create'
  root 'logins#login'

  delete 'main/sign_out', to: 'mains#destroy'
end
