Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  
  resources :users
  root 'scores#index'
  require 'sidekiq/web'
  require 'sidekiq/cron/web'
  mount Sidekiq::Web => '/sidekiq'

  resources :scores, only: [:index, :show] do
    collection do
      get :scrape
      get :scrape_team_data
      get :scrape_upcoming_matches
      get :scrape_team_squad_members
    end
  end

  resources :teams, only: :index
  resources :matches, only: [:index, :show] do
    member do
      get :initialize_scorecard
      get :update_scorecard
      get :live_score
      get :add_notifications
      post :create_notifications
    end

    collection do
      get :update_status
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
