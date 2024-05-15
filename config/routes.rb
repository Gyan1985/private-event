Rails.application.routes.draw do
  devise_for :users
  root 'events#index'
  get 'hosted_events', to: 'users#hosted_events'
  resources :events do
    member do
      post :join
      delete :leave
    end
  end
end
