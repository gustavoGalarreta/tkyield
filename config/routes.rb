Rails.application.routes.draw do

  root to: "home#index"

  resources :users, only: [:index, :new, :edit, :create, :update], path: "collaborators" do
    get 'show_user_project', to: 'users#projects', on: :member
    patch 'update_user_project', to: 'users#update_projects', on: :member
    get 'resend_confirmation', to: 'users#resend_confirmation', on: :member
  end

  resources :tasks

  resources :projects do
    get 'tasks', on: :collection
  end

  resources :clients

  resources :timesheets, except: [:show, :new, :edit] do
    get 'toggle_timesheet', on: :member
  end

  devise_for :users, :controllers => { :passwords => 'user_device/passwords', :confirmations => 'user_device/confirmations' }
  devise_scope :user do
    patch "/confirm" => "user_device/confirmations#confirm"
  end

end
