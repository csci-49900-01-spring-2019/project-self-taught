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
    resources :notes, :tests
  end

  namespace 'api', path: '/', constraints: { subdomain: 'api' } do
    namespace 'v1' do
      mount_devise_token_auth_for 'User', at: 'users', constraints: { format: 'json' },
        controllers:
        { confirmations:      'api/v1/users/confirmations',
          passwords:          'api/v1/users/passwords',
          omniauth_callbacks: 'api/v1/users/omniauth_callbacks',
          registrations:      'api/v1/users/registrations',
          sessions:           'api/v1/users/sessions',
          token_validations:  'api/v1/users/token_validations' }
    end
  end
end
