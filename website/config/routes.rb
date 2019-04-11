Rails.application.routes.draw do
  devise_for :users,
    controllers: {  confirmations: 'users/confirmations', mailer: 'users/mailer',
                    passwords: 'users/passwords', registrations: 'users/registrations',
                    sessions: 'users/sessions', shared: 'users/shared', unlocks: 'users/unlocks' }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "homepage#index"

  get '/notebooks/user', action: :user, controller: 'notebooks'
  get '/notebooks/:id', to: 'notebooks#show'
  get '/notebooks/:id/edit', to: 'notebooks#edit'
end
