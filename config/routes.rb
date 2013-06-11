Tsushin::Application.routes.draw do
  root :to => 'root#index'

  match '/login',                   :to => 'users/sessions#new',    :as => 'new_user_session'
  match '/auth/:provider/callback', :to => 'users/sessions#create', :as => 'create_user_session'

  post 'send/:template_name' => 'send#post'

  resources :templates do
    member do
      get 'activate'
      get 'duplicate'
    end
    collection do
      post 'try'
    end
  end

  resources :sent_emails, :only => [:index, :show]
  resources :jobs, :only => [:index]


  class AuthConstraint
    def matches?(request)
      Rails.application.config.authorized_users.include? request.session[:user_id]
    end
  end
  constraints(AuthConstraint.new) do
    match     'delayed_job' => DelayedJobWeb, :anchor => false
  end
end
