Rails.application.routes.draw do

  
  root to: "home#index"

  resources :users , only: [:index]

  resources :tasks

  resources :projects

  resources :clients

  resources :timesheets , only: [:index]

  devise_for :users

end
