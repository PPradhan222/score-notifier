Rails.application.routes.draw do
  root 'scores#index'

  resources :scores, only: [:index, :show] do
    collection do
      get :scrape
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
