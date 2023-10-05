Rails.application.routes.draw do
  resources :users
  resources :quests

  get 'searches/result'
  get 'starts/start_p'
  get 'ranking/rank_p'
  get 'mains/main'
  get 'logins/login'

  post 'logins/sign_in', to: 'logins#create' # 수정된 라우팅 이름

  # 수정된 라우팅 이름 및 경로
  post 'starts/submit_answer', to: 'starts#submit_answer', as: 'submit_answer_start'

  root 'logins#login'

  delete 'mains/sign_out', to: 'mains#destroy' # 수정된 라우팅 이름
end