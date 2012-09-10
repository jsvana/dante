Dante::Application.routes.draw do
  root to: 'requests#index'

  resources :users
  resources :requests do
    member do
      post :upvote
      post :downvote
    end
  end
end
