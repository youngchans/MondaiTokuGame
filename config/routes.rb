Rails.application.routes.draw do
  get 'download_csv/index'
  get 'download_csv/show'
  get 'download_csv/edit'
  resources :tasks
  resources :users
  resources :quests
  get 'finds/check'
  get 'finds/find'

  get 'quests/index', to: 'quests#search'
  get 'quests/download', to: 'quests#download'


  get 'searches/result'

  get 'starts/start_p'
  get 'starts/select'
  get 'starts/error'

  get 'ranking/rank_p'

  get 'mains/main'

  get 'logins/login'

  get 'mains/change_p'

  post 'find/validate', to: 'finds#validate'
  post 'find/search', to: 'finds#search'
  post 'login/sign_in', to: 'logins#create'
  post 'change_p/update', to: 'mains#update'
  post 'start/submit_answer', to: 'starts#submit_answer', as: 'submit_answer_start'

  root 'logins#login'

  delete 'main/sign_out', to: 'mains#destroy'

end