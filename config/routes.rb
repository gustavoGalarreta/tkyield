Rails.application.routes.draw do
  root to: "home#index"
  resources :users, only: [:index, :new, :edit, :create, :update], path: "collaborators" do
    get 'show_user_project', to: 'users#projects', on: :member
    patch 'update_user_project', to: 'users#update_projects', on: :member
    get 'resend_confirmation', to: 'users#resend_confirmation', on: :member
  end
  resources :tasks
  resources :clients
  resources :projects do
    get 'tasks', on: :collection
  end
  resources :timesheets, except: [:show, :new, :edit] do
    get 'toggle_timesheet', on: :member
  end
  namespace :reports do
    get 'list', to: 'reports#index'
    resources :projects, only: :show
    resources :users, only: :show
    resources :clients, only: :show
  end
  # resources :reports

  devise_for :users, :controllers => { :passwords => 'user_device/passwords', :confirmations => 'user_device/confirmations' }
  devise_scope :user do
    patch "/confirm" => "user_device/confirmations#confirm"
  end

end
