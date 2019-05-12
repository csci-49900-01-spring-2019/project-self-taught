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

    devise_for :users,
      controllers:
      { confirmations: 'users/confirmations', mailer: 'users/mailer',
        passwords: 'users/passwords', registrations: 'users/registrations',
        sessions: 'users/sessions', shared: 'users/shared', unlocks: 'users/unlocks' }

    get 'users/:id/notebooks', action: :user, controller: 'notebooks', as: :user_notebooks
    get 'users/:id/notes', action: :user, controller: 'notes', as: :user_notes
    get 'users/:id/tests', action: :user, controller: 'tests', as: :user_tests

    resources :notebooks do
      resources :notes, :questions, :tests
    end
  end

  namespace :api, path: nil, constraints: ApiSubDomainConstraint do
    root to: "home#index"
    
    namespace :v1 do
      root to: "home#index"
      
      mount_devise_token_auth_for 'User', at: 'users', constraints: { format: 'json' },
        controllers:
        { confirmations:      'api/v1/users/confirmations',
          passwords:          'api/v1/users/passwords',
          omniauth_callbacks: 'api/v1/users/omniauth_callbacks',
          registrations:      'api/v1/users/registrations',
          sessions:           'api/v1/users/sessions',
          token_validations:  'api/v1/users/token_validations' }
      
      get 'users/:id/notebooks', action: :user, controller: 'notebooks', as: :user_notebooks
      get 'users/:id/notes', action: :user, controller: 'notes', as: :user_notes
      get 'users/:id/questions', action: :user, controller: 'questions', as: :user_questions
      get 'users/:id/tests', action: :user, controller: 'tests', as: :user_tests

      resources :notebooks, only: [:index, :create, :show, :update, :destroy], constraints: { format: 'json' } do
        resources :notes, only: [:index, :create, :show, :update, :destroy]
        resources :questions, only: [:index, :create, :show, :update, :destroy]
        resources :tests, only: [:index, :create, :show, :update, :destroy]
      end 
    end
  end
end
