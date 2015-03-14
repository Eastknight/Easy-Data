Rails.application.routes.draw do


  resources :domains

  devise_for :users
  root to: 'home#index'

end
