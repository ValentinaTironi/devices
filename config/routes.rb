Rails.application.routes.draw do

  resources :users do
    resources :devices
  end

  namespace :api, defaults: { format: 'json' } do
    post :login, to: 'login#show'
  end

  root 'users#index'
end
