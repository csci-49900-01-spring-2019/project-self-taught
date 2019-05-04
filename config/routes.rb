Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "homepage#index"
  get 'mobile', action: :mobile, controller: 'homepage', as: :mobile
  get 'contact', action: :contact, controller: 'homepage', as: :contact
  get 'eula', action: :eula, controller: 'homepage', as: :eula
  get 'support', action: :support, controller: 'homepage', as: :support

  devise_for :users,
    controllers:
    { confirmations: 'users/confirmations', mailer: 'users/mailer',
      passwords: 'users/passwords', registrations: 'users/registrations',
      sessions: 'users/sessions', shared: 'users/shared', unlocks: 'users/unlocks' }

  get 'users/:id/notebooks', action: :user, controller: 'notebooks', as: :user_notebooks
  get 'users/:id/notes', action: :user, controller: 'notes', as: :user_notes
  get 'users/:id/tests', action: :user, controller: 'tests', as: :user_tests

  resources :notebooks do
    resources :notes, :tests, :test_sessions
  end
  
end
