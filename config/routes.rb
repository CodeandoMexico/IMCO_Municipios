Rails.application.routes.draw do

  post "cities/search"

  # devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks", :registrations => "registrations" }
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }

  resources :cities, only: [:show, :update] do
    get 'about'
    get 'aviso'
    resources :inspections, only: [:index, :show]
    resources :inspectors, only: [:index, :show]
    resources :procedure_lines, only: [:index,:show]
    resources :formation_steps, only: [:index]
    resources :complaints, only: [:new, :create, :edit, :update]
    resources :reminders, only: [:new,:index,:destroy, :edit, :update]
    Reminders
  end

  resource :dashboard, only: :show, controller: :dashboard do
    resources :inspections, only: [:index, :new, :create, :edit, :update, :destroy], controller: 'dashboard/inspections'
    resources :inspectors, only: [:index, :new, :create, :edit, :update, :destroy], controller: 'dashboard/inspectors'
    resources :formation_steps, only: [:index, :new, :create, :edit, :update, :destroy], controller: 'dashboard/formation_steps'
    resources :lines, only: [:index, :new, :create, :edit, :update, :destroy], controller: 'dashboard/lines'
    resources :dependencies, only: [:index, :new, :create, :edit, :update, :destroy], controller: 'dashboard/dependencies'
    resources :requirements, only: [:index, :new, :create, :edit, :update, :destroy], controller: 'dashboard/requirements'
    resources :procedures, only: [:index, :new, :create, :edit, :update, :destroy], controller: 'dashboard/procedures'
    resources :reports, only: [:index, :show, :destroy], controller: 'dashboard/reports'
    resources :cities, only: [:show], controller: 'dashboard/cities' do
         resources :contacts, only: [:index, :edit, :update], controller: 'dashboard/contacts'
    end
  end

  resources :users, only: [:new, :create, :edit, :update,:destroy]

  root 'imcos#index'
end
