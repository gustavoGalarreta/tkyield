Rails.application.routes.draw do

  
  root to: "home#index"

  resources :users, only: [:index, :new, :edit, :create, :update] #, as: "collaborator"

  resources :tasks

  resources :projects do
    get 'tasks', on: :collection
  end

  resources :clients

  resources :timesheets do
    get 'toggle_timesheet', on: :collection
  end

  devise_for :users, :controllers => { :confirmations => 'confirmations', :registrations => 'registrations' }
  devise_scope :user do
    patch "/confirm" => "confirmations#confirm"
  end

end
