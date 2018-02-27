Rails.application.routes.draw do

  resources :users do
    resources :devices
  end

  namespace :api, defaults: { format: 'json' } do
    post :users, to: 'users#login'
  end

  root 'users#index'
end
