Dante::Application.routes.draw do
  root to: 'dashboards#index'

  resources :users
  resources :dashboards
  resources :requests
end
