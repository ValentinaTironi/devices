Rails.application.routes.draw do

  resources :users do
      resources :devices
    end
  root 'users#index'
end
