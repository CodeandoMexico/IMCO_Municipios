module Dashboard
  class UploadsController < ApplicationController
    before_filter :set_city, :set_status
    layout 'dashboard'

    require 'fileutils'

  def index
    unless @status.nil?
      if @status.status == "terminado" 
        @logs = true
        @success_datum = Datum.where(id_town: current_user.city_id, type: "success")
        @errors_datum= Datum.where(id_town: current_user.city_id, type: "errors")
        @warnings_datum= Datum.where(id_town: current_user.city_id, type: "warnings")

      elsif @status.status == "iniciado"
        @dialog = true
      end
    end
  end


    def create
      if params[:post]
        file_dependency = params[:post][:dependency_file]
        file_lines = params[:post][:line_file]
        file_inspectors = params[:post][:inspector_file]
        file_requirements = params[:post][:requirement_file]
        file_inspections = params[:post][:inspection_file]
        file_formation_steps = params[:post][:formation_step_file]
        file_procedures = params[:post][:procedure_file]
          if validate_params(file_dependency, file_lines, file_inspectors, file_requirements, file_inspections, file_formation_steps, file_procedures) 
            unless @status.nil?
              @status.delete
            end
            
            delete_files

            if @status.status == "iniciado"
              @status.status == "terminado"
              LoadWorker.perform_async(@user_id,@city.id,file_dependency.tempfile.path, file_lines.tempfile.path, file_inspectors.tempfile.path, file_requirements.tempfile.path, file_inspections.tempfile.path, file_formation_steps.tempfile.path, file_procedures.tempfile.path)
              redirect_to dashboard_upload_index_path,  notice:  "Espere porfavor estamos subiendo los cambios"
            end

          else
            redirect_to dashboard_upload_index_path,  error:  "Debes agregar todos los datasets  NINGUN CAMBIO FUE EFECTUADO"
          end 
      else
        redirect_to dashboard_upload_index_path,  error:  "Debes agregar todos los datasets  NINGUN CAMBIO FUE EFECTUADO"
      end
    end



  private
    def set_city
      @city = City.find(current_user.city_id)
      @user_id = current_user.id
      @success = []
      @errors = []
      @warnings = []
    end

    def set_status
      unless Uploads.where(id_user: current_user.id).blank?
        @status = Uploads.where(id_user: current_user).first
        if @status.created_at.utc < Time.now.utc - 15.minutes
          @status.delete
        end
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

    def delete_files
        Datum.where(id_town: current_user.city_id).delete_all
        @status = Uploads.where(id_user: current_user.id).first_or_create
        @status.status = 'iniciado'
        if @status.save
          puts '*************************** status creado ***************************'
        end
    end

  end
end