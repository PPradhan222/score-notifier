Rails.application.routes.draw do
  root "scores#index"

  get 'scores/index'
  get 'scores/show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
