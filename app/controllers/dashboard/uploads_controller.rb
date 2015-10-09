module Dashboard
  class UploadsController < ApplicationController
    before_filter :set_city
    layout 'dashboard'

    def index

      if params[:post]
        file_dependency = params[:post][:dependency_file]
        file_lines = params[:post][:line_file]
        file_inspectors = params[:post][:inspector_file]
        file_requirements = params[:post][:requirement_file]
        file_inspections = params[:post][:inspection_file]
        file_formation_steps = params[:post][:formation_step_file]
        file_procedures = params[:post][:procedure_file]
          if validate_params(file_dependency, file_lines, file_inspectors, file_requirements, file_inspections, file_formation_steps, file_procedures) 
           #crear 3 archivos para cada salida success_idUser, errors_idUser, warnings_idUser
            LoadWorker.perform_async(current_user,@city.id,file_dependency, file_lines, file_inspectors, file_requirements, file_inspections, file_formation_steps, file_procedures)
            redirect_to dashboard_upload_index_path({:logs => true}),  notice:  "Espere porfavor estamos subiendo los cambios"
          else
            redirect_to dashboard_upload_index_path,  error:  "Debes agregar todos los datasets  NINGUN CAMBIO FUE EFECTUADO"
          end 
      end

      if params[:logs]
        @logs = true
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
    end

    def validate_params(file_dependency, file_lines, file_inspectors, file_requirements, file_inspections, file_formation_steps, file_procedures)
      if file_lines.blank? || file_lines.blank? || file_inspectors.blank? || file_requirements.blank? || file_inspections.blank? || file_formation_steps.blank? || file_procedures.blank?
        return false
      end
        return true
    end

  end
end