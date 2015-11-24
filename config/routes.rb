Rails.application.routes.draw do

  post "cities/search"

  devise_for :users, :path_names => { :sign_in => "inicio_sesion", :sign_out => "salir", :sign_up => "registro" }, :controllers => { :omniauth_callbacks => "omniauth_callbacks"}
 
  match '/user_formation_steps', to: 'user_formation_steps#update', via: :post
  match '/user_procedures', to: 'user_procedures#update', via: :post
  match '/user_requirements', to: 'user_requirements#update', via: :post

  resources :municipio, as: :cities, only: [:show, :update, :edit] , :path_names => { :edit => "editar" }, controller: :cities do
    get 'about', :path => "acercade"
    get 'aviso', :path => "aviso"
    resources :inspecciones, as: :inspections, only: [:index, :show], controller: :inspections do
      collection do
        get 'download_csv_inspections', :path => "descargar_csv_inspecciones"
        get 'download_csv_inspections_show', :path => "descargar_y_mostrar_csv_inspecciones"
      end
    end
    resources :inspectores, as: :inspectors, only: [:index, :show], controller: :inspectors do
      collection do
        get 'download_csv_inspector', :path => "descargar_csv_inspectores"
      end
    end
    resources :tramites, as: :procedure_lines, only: [:index,:show], controller: :procedure_lines do
      collection do
        get 'download_csv_procedure_line', :path => "descargar_csv_tramites_por_giro"
        get 'download_csv_requirements', :path => "descargar_csv_requisitos"
      end
    end
    resources :tramites_de_apertura, as: :formation_steps, only: [:index], controller: :formation_steps do
      collection do
        get 'download_csv_formation_steps_municipal', :path => "descargar_csv_tramites_de_apertura_municipal"
        get 'download_csv_formation_steps_federal', :path => "descargar_csv_tramites_de_apertura_federal"
      end
    end
    resources :denuncias, as: :complaints, only: [:new, :create, :edit, :update], :path_names => { :edit => "editar" ,:new => "nuevo" }, controller: :complaints

    resources :recordatorios, as: :reminders, only: [:index, :new, :create, :edit, :update, :destroy], :path_names => { :edit => "editar", :new => "nuevo" }, controller: :reminders

    resources :usuarios, as: :users, only: :index , controller: :users do
      collection do
        get 'download_csv_business', :path => "descargar_csv_negocios"
      end
    end
  end

  resources :aprende, as: :learns, controller: :learns

  resource :panel, as: :dashboard, only: :show, controller: :dashboard do
    get 'aviso'
    resources :aprende, as: :learns, controller: 'dashboard/learns', :path_names => { :edit => "editar", :new => "nuevo" }
    resources :carga, as: :upload, controller: 'dashboard/uploads'
    resources :inspecciones, as: :inspections, only: [:index, :new, :create, :edit, :update, :destroy], :path_names => { :edit => "editar", :new => "nuevo" }, controller: 'dashboard/inspections'
    resources :inspectores, as: :inspectors, only: [:index, :new, :create, :edit, :update, :destroy], :path_names => { :edit => "editar", :new => "nuevo" }, controller: 'dashboard/inspectors'
    resources :tremites_de_apertura, as: :formation_steps, only: [:index, :new, :create, :edit, :update, :destroy], :path_names => { :edit => "editar", :new => "nuevo" }, controller: 'dashboard/formation_steps'
    resources :giros, as: :lines, only: [:index, :new, :create, :edit, :update, :destroy], :path_names => { :edit => "editar", :new => "nuevo" }, controller: 'dashboard/lines'
    resources :dependencias, as: :dependencies, only: [:index, :new, :create, :edit, :update, :destroy], :path_names => { :edit => "editar", :new => "nuevo" }, controller: 'dashboard/dependencies'
    resources :requisitos, as: :requirements, only: [:index, :new, :create, :edit, :update, :destroy], :path_names => { :edit => "editar", :new => "nuevo" }, controller: 'dashboard/requirements'
    resources :tramites, as: :procedures, only: [:index, :new, :create, :edit, :update, :destroy], :path_names => { :edit => "editar", :new => "nuevo" }, controller: 'dashboard/procedures'
    resources :reportes, as: :reports, only: [:index, :show, :destroy], controller: 'dashboard/reports'
    resources :negocios, as: :business, only: [:index, :show], controller: 'dashboard/business'
    resources :administradores, as: :admins, :path_names => { :edit => "editar"}, controller: 'dashboard/admins'
    resources :municipio, as: :cities, :path_names => { :edit => "editar", :new => "nuevo" }, controller: 'dashboard/cities' do
      resources :contactos, as: :contacts, only: [:index, :edit, :update], :path_names => { :edit => "editar" }, controller: 'dashboard/contacts'
    end
  end

  resources :usuarios, as: :users, only: [:new, :create, :edit, :update], :path_names => { :edit => "editar", :new => "nuevo" }, controller: :users do
    resources :negocios, as: :business, controller: 'business'
  end



  resources :imcos do
     collection do
      get 'change_business', :path => "cambiar_negocios"
    end
  end

  root 'imcos#index'

  #if Rails.env.production? || Rails.env.development?  
   # match '/404', to: 'errors#file_not_found', via: :all
  #  match '/422', to: 'errors#unprocessable', via: :all
  #  match '/500', to: 'errors#internal_server_error', via: :all
  #end

end
