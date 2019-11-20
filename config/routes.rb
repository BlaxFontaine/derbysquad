Rails.application.routes.draw do
  root to: 'pages#home'
  get "leagues/:id", to: 'pages#home'
  get "leagues/new", to: 'pages#home'
  # API routing
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :leagues, only: [ :index, :show, :create ]
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :leagues do
    resources :teams
  end
  resources :teams
end
