Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #resources :users, only: [:show] do
  #end
  root 'homepage#index'
  
  get '/user/signup', to:'users#new'
  get '/user/login', to: 'users#access'
end
