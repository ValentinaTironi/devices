Rails.application.routes.draw do

  resources :devices

  root 'devices#index'
end
