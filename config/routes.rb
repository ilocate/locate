Rails.application.routes.draw do
  resources :points
  resources :tracks
  resources :labels
  resources :users

  namespace :api do
    resources :locates
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
