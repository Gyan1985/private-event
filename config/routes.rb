Rails.application.routes.draw do
  devise_for :users
  root 'events#index'

  resources :users, only: [] do
    collection do
      get :hosted_events
      get :attendent_events
    end
  end

  resources :events do
    member do
      post :join
      delete :leave
    end
  end
end
