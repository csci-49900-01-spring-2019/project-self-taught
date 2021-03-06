Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  module MainSubDomainConstraint
    def self.matches? request
      request.subdomain == nil || request.subdomain == '' || request.subdomain == 'www'
    end
  end

  module ApiSubDomainConstraint
    def self.matches? request
      request.subdomain == 'api' || request.subdomain == 'www.api'
    end
  end

  constraints MainSubDomainConstraint do
    root to: "homepage#index"
    get 'mobile', action: :mobile, controller: 'homepage', as: :mobile
    get 'contact', action: :contact, controller: 'homepage', as: :contact
    get 'eula', action: :eula, controller: 'homepage', as: :eula
    get 'support', action: :support, controller: 'homepage', as: :support

    get 'search', action: :index, controller: 'search', as: :search

    devise_for :users,
      controllers:
      { confirmations: 'users/confirmations', mailer: 'users/mailer',
        passwords: 'users/passwords', registrations: 'users/registrations',
        sessions: 'users/sessions', shared: 'users/shared', unlocks: 'users/unlocks' }

    get 'users/:user_id/notebooks', action: :user, controller: 'notebooks', as: :user_notebooks
    get 'users/:user_id/notes',     action: :user, controller: 'notes',     as: :user_notes
    get 'users/:user_id/questions', action: :user, controller: 'questions', as: :user_questions
    get 'users/:user_id/tests',     action: :user, controller: 'tests',     as: :user_tests
    
    get 'notes',     action: :index, controller: 'notes',     as: :public_notes
    get 'questions', action: :index, controller: 'questions', as: :public_questions
    get 'tests',     action: :index, controller: 'tests',     as: :public_tests

    resources :notebooks, param: :notebook_id
    resources :notes,     param: :note_id,     path: '/notebooks/:notebook_id/notes', as: :notebook_notes
    resources :questions, param: :question_id, path: '/notebooks/:notebook_id/questions', as: :notebook_questions

    resources :tests,     param: :test_id,     path: '/notebooks/:notebook_id/tests', as: :notebook_tests
    post 'notebooks/:notebook_id/tests/:test_id/session', action: :create_session, controller: 'tests', as: :notebook_test_sessions
    get  'notebooks/:notebook_id/tests/:test_id/sessions/:session_id', action: :show_session, controller: 'tests', as: :notebook_test_session
  end

  namespace :api, path: nil, constraints: ApiSubDomainConstraint do
    root to: "home#index"
    
    namespace :v1 do
      root to: "home#index"
      get 'search', action: :index, controller: 'search', as: :search

      mount_devise_token_auth_for 'User', at: 'users', constraints: { format: 'json' },
        controllers:
        { confirmations:      'api/v1/users/confirmations',
          passwords:          'api/v1/users/passwords',
          omniauth_callbacks: 'api/v1/users/omniauth_callbacks',
          registrations:      'api/v1/users/registrations',
          sessions:           'api/v1/users/sessions',
          token_validations:  'api/v1/users/token_validations' }
      
      get 'users/:user_id/notebooks', action: :user, controller: 'notebooks', as: :user_notebooks
      get 'users/:user_id/notes',     action: :user, controller: 'notes',     as: :user_notes
      get 'users/:user_id/questions', action: :user, controller: 'questions', as: :user_questions
      get 'users/:user_id/tests',     action: :user, controller: 'tests',     as: :user_tests

      resources :notebooks, param: :notebook_id, only: [:index, :create, :show, :update, :destroy], constraints: { format: 'json' }
      resources :notes,     param: :note_id, path: '/notebooks/:notebook_id/notes', as: :notebook_notes, only: [:index, :create, :show, :update, :destroy], constraints: { format: 'json' }
      resources :questions, param: :question_id, path: '/notebooks/:notebook_id/questions', as: :notebook_questions, only: [:index, :create, :show, :update, :destroy], constraints: { format: 'json' }
      resources :tests,     param: :test_id, path: '/notebooks/:notebook_id/tests', as: :notebook_tests, only: [:index, :create, :show, :update, :destroy], constraints: { format: 'json' }
    end
  end
end
