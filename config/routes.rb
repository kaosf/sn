Rails.application.routes.draw do
  resource :session
  # resources :passwords, param: :token
  root to: redirect("/sns")
  get "menu" => "home#menu"
  resources :home, only: %i[index]
  resources :sns, only: %i[index show]
  resources :sns, only: %i[create], defaults: { format: :json }
  resources :sn_all_reads, only: %i[create]
  resources :sn_all_deletions, only: %i[create]
  resources :sn_exports, only: %i[index]
  resources :sn_imports, only: %i[new create]
  resources :sn_notifications, only: %i[create]
  resources :sn_reads, only: %i[update], defaults: { format: :json }
  resources :sn_subscriptions, only: %i[index show new create destroy]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
