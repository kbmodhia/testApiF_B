Rails.application.routes.draw do
  resources :group_keywords
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html  
  root to: "home#index"

  # get json data for API
  get "userGroup.json", to: "home#getUserGroups"

  # sidekiq web 
  require 'sidekiq/web'
  require 'sidekiq/cron/web'
  mount Sidekiq::Web => '/sidekiq'
end
