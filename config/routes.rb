Rails.application.routes.draw do

  post "cities/search"

  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks"}

  match '/user_formation_steps', to: 'user_formation_steps#update', via: :post
  match '/user_procedures', to: 'user_procedures#update', via: :post
  match '/user_requirements', to: 'user_requirements#update', via: :post

  resources :cities, only: [:show, :update, :edit] do
    get 'about'
    get 'aviso'
    resources :inspections, only: [:index, :show] do
      collection do
        get 'download_csv_inspections'
         get 'download_csv_inspections_show'
      end
    end
    resources :inspectors, only: [:index, :show] do
      collection do
        get 'download_csv_inspector'
      end
    end
    resources :procedure_lines, only: [:index,:show] do
      collection do
        get 'download_csv_procedure_line'
        get 'download_csv_requirements'
      end
    end
    resources :formation_steps, only: [:index] do
      collection do
        get 'download_csv_formation_steps_municipal'
        get 'download_csv_formation_steps_federal'
      end
    end
    resources :complaints, only: [:new, :create, :edit, :update]
    resources :reminders, only: [:index, :new, :create, :edit, :update, :destroy], controller: 'reminders'
    resources :users, only: :index do
      collection do
        get 'download_csv_business'
      end
    end
  end

  resource :dashboard, only: :show, controller: :dashboard do
    get 'aviso'
    resources :inspections, only: [:index, :new, :create, :edit, :update, :destroy], controller: 'dashboard/inspections'
    resources :inspectors, only: [:index, :new, :create, :edit, :update, :destroy], controller: 'dashboard/inspectors'
    resources :formation_steps, only: [:index, :new, :create, :edit, :update, :destroy], controller: 'dashboard/formation_steps'
    resources :lines, only: [:index, :new, :create, :edit, :update, :destroy], controller: 'dashboard/lines'
    resources :dependencies, only: [:index, :new, :create, :edit, :update, :destroy], controller: 'dashboard/dependencies'
    resources :requirements, only: [:index, :new, :create, :edit, :update, :destroy], controller: 'dashboard/requirements'
    resources :procedures, only: [:index, :new, :create, :edit, :update, :destroy], controller: 'dashboard/procedures'
    resources :reports, only: [:index, :show, :destroy], controller: 'dashboard/reports'
    resources :business, only: [:index, :show], controller: 'dashboard/business'
    resources :cities, only: [:show], controller: 'dashboard/cities' do
      resources :contacts, only: [:index, :edit, :update], controller: 'dashboard/contacts'
    end
  end

  resources :users, only: [:new, :create, :edit, :update] do
    resources :business, controller: 'business'
  end

  resources :imcos do
    collection do
      get 'change_business'
    end
  end
  root 'imcos#index'

end
