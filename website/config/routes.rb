Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #resources :users, only: [:show] do
  #end
  root 'homepage#index'
  
  get '/user/signup', action: :signup, controller: 'users'
  get '/user/signup/complete', action: :complete_signup, controller: 'users'
  get '/user/login', action: :login, controller: 'users'
  get '/user/recover', action: :recover, controller: 'users'
  get '/user/password/reset', action: :reset_password, controller: 'users'

  get '/notebooks/user', action: :user, controller: 'notebooks'
  get '/notebooks/:id', to: 'notebooks#show'
  get '/notebooks/:id/edit', to: 'notebooks#edit'

end
