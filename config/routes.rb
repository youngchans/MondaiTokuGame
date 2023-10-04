Rails.application.routes.draw do
  resources :quests
  get 'start/start_p'
  get 'ranking/rank_p'
  get 'mains/main'
  resources :users

  get 'logins/login'

  post 'login/sign_in', to: 'logins#create'
  root 'logins#login'

  delete 'main/sign_out', to: 'mains#destroy'
end
