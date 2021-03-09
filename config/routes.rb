Rails.application.routes.draw do
  root 'scores#index'

  resources :scores, only: [:index, :show] do
    collection do
      get :scrape
      get :scrape_team_data
      get :scrape_upcoming_matches
    end
  end

  resources :teams, only: :index
  resources :matches, only: :index
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
