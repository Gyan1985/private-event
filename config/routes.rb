Rails.application.routes.draw do
  devise_for :users
  root 'events#index'
  get 'hosted_events', to: 'users#hosted_events'
  resources :events, only: %i[index new create]
end
