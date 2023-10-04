Rails.application.routes.draw do
  get 'ques/index'
  get 'ques/edit/:post_id' => 'ques#edit'
  get 'ques/update'
  get 'ques/destroy'
  get 'ques/main'

  get 'start/start_p'

  get 'ranking/rank_p'
  get 'mains/main'

  resources :users
  resources :ques

  get 'logins/login'

  post 'login/sign_in', to: 'logins#create'
  root 'logins#login'

  delete 'main/sign_out', to: 'mains#destroy'
end
