module Dashboard
  class UploadsController < ApplicationController
    rescue_from ::ActiveRecord::RecordNotFound, with: :error_occurred
    rescue_from ::NameError, with: :error_occurred
    rescue_from ::ActionController::RoutingError, with: :error_occurred
    rescue_from ::Exception, with: :error_occurred
    before_filter :set_city, :set_status
    layout 'dashboard'

    require 'fileutils'
    def index
      unless @status.nil?
        if @status.status == "terminado"
          @logs = true
          @status.delete
        elsif @status.status == "iniciado"
          @dialog = true
        end
      end

      if params[:post]
        file_dependency = params[:post][:dependency_file]
        file_lines = params[:post][:line_file]
        file_inspectors = params[:post][:inspector_file]
        file_requirements = params[:post][:requirement_file]
        file_inspections = params[:post][:inspection_file]
        file_formation_steps = params[:post][:formation_step_file]
        file_procedures = params[:post][:procedure_file]
          if validate_params(file_dependency, file_lines, file_inspectors, file_requirements, file_inspections, file_formation_steps, file_procedures) 
                 
            if @status.nil?
              @status = Uploads.create(id_user: current_user.id,status: "creado")
              make_files
            end

            if @status.status == "iniciado"
              LoadWorker.perform_async(@user_id,@city.id,file_dependency, file_lines, file_inspectors, file_requirements, file_inspections, file_formation_steps, file_procedures)
              redirect_to dashboard_upload_index_path,  notice:  "Espere porfavor estamos subiendo los cambios"
            end

          else
            redirect_to dashboard_upload_index_path,  error:  "Debes agregar todos los datasets  NINGUN CAMBIO FUE EFECTUADO"
          end 
      end
    end

    def create
      if params[:post]
        redirect_to dashboard_upload_index_path(params)
      else
        redirect_to dashboard_upload_index_path,  error:  "Debes agregar todos los datasets  NINGUN CAMBIO FUE EFECTUADO"
      end
    end



  private
    def set_city
      @city = City.find(current_user.city_id)
      @user_id = current_user.id
      @root_path_dir = "lib/temp/upload_#{@user_id}"
      @success = []
      @errors = []
      @warnings = []
    end

    def set_status
      unless Uploads.where(id_user: current_user.id).blank?
        @status = Uploads.where(id_user: current_user).last
      end
      @dialog = false
      @logs = false
    end

    def validate_params(file_dependency, file_lines, file_inspectors, file_requirements, file_inspections, file_formation_steps, file_procedures)
      if file_lines.blank? || file_lines.blank? || file_inspectors.blank? || file_requirements.blank? || file_inspections.blank? || file_formation_steps.blank? || file_procedures.blank?
        return false
      end
        return true
    end

    def make_files
      @status.status = 'iniciado'
      if @status.save
         puts '***************Iniciado******************'
        delete_files
        Dir::mkdir("#{@root_path_dir}")
        f = File.open("#{@root_path_dir}/success.txt","w+")
        f.close
        f = File.open("#{@root_path_dir}/errors.txt","w+")
        f.close
        f = File.open("#{@root_path_dir}/warnings.txt","w+")
        f.close
        puts '*************************** Archivos creados ***************************'
      end
    end

    def delete_files
      if Dir.exist?("#{@root_path_dir}")
        FileUtils.rm_rf("#{@root_path_dir}")
        puts '*************************** borre el directorio #{@root_path_dir} ***************************'
      else
        puts '*************************** No existe el directorio Nada que borrar***************************'
      end
    end


  protected

    def error_occurred(exception)
      puts '******************ERROR************************'
      #delete_files
      puts exception.message
      #redirect_to dashboard_upload_index_path,  error:  "Error grabe al subor los datos, intenta de nuevo, NINGUN CAMBIO FUE EFECTUADO"
    end

  end
end