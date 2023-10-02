Rails.application.routes.draw do
  get 'ques/ques_p'
  get 'start/start_p'
  get 'm_k/m_k_p'
  get 'ranking/rank_p'
  get 'mains/main'

  resources :users
  get 'logins/login'

  post 'login/sign_in', to: 'logins#create'
  root 'logins#login'

  delete 'main/sign_out', to: 'mains#destroy'
end
