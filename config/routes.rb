Rails.application.routes.draw do


  resources :domains do
    resources :verification, only: [:create]
  end

  devise_for :users
  root to: 'home#index'

  namespace :api do
    resources :events, only: [:create]
    match 'events.json' => 'events#create', via: :options, as: :events_options
  end

end
