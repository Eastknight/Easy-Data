Rails.application.routes.draw do


  resources :domains do
    resources :verification, only: [:create]
  end

  authenticated :user do
    root :to => "domains#index", as: :logged_in_root
  end

  devise_for :users
  root to: 'home#index'

  namespace :api do
    resources :events, only: [:create]
    match 'events.json' => 'events#create', via: :options, as: :events_options
  end

end
