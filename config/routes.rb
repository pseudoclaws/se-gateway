Rails.application.routes.draw do
  # Defines the root path route ("/")
  root "ui#index"

  devise_for :users, skip: :all
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        registrations: :registrations,
        confirmations: :confirmations
      }
      resources :connections, only: %i[index show update destroy] do
        resources :accounts, only: %i[show]
      end
      resources :connection_sessions, only: %i[create]
      namespace :callbacks do
        resources :success, only: :create
        resources :destroy, only: :create
        resources :notify, only: :create
        resources :service, only: :create
        resources :fail, only: :create
      end
    end
  end

  match '*path' => 'ui#index', via: :all
end
