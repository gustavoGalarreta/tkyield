Rails.application.routes.draw do

  
  root to: "home#index"

  resources :users , only: [:index]

  resources :tasks

  resources :projects do
  	get 'tasks', on: :collection
  end

  resources :clients

  resources :timesheets do
    get 'toogle_timesheet', on: :member
  end


  devise_for :users

end
