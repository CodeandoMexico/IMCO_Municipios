module Dashboard
  class CitiesController < ApplicationController
    before_filter :set_city
    layout 'dashboard'

    def update
      if params[:post]
    
        file_dependency = params[:post][:dependency_file]
        file_lines = params[:post][:line_file]
        file_inspectors = params[:post][:inspector_file]
        file_requirements = params[:post][:requirement_file]
        file_inspections = params[:post][:inspection_file]
        file_formation_steps = params[:post][:formation_step_file]
        file_procedures = params[:post][:procedure_file]

        if validate_params(file_dependency, file_lines, file_inspectors, file_requirements, file_inspections, file_formation_steps, file_procedures)
          
          $errors = []
          $warnings = []
          $success = []

          CsvUploads.delete_all_data(@city)
          LoadWorker.perform_async(current_user,@city,file_dependency, file_lines, file_inspectors, file_requirements, file_inspections, file_formation_steps, file_procedures)
          
          redirect_to upload_dashboard_path({:dialog => true}),  notice:  "Espere porfavor estamos subiendo los cambios"
        else
          redirect_to upload_dashboard_path,  error:  "Debes agregar todos los datasets  NINGUN CAMBIO FUE EFECTUADO"
        end
      else
        redirect_to upload_dashboard_path,  error:  "Debes agregar todos los datasets  NINGUN CAMBIO FUE EFECTUADO"
      end

    end



    private

    def set_city
      $errors = nil
      $warnings = nil
      $success = nil
      @city ||= City.find(current_user.city_id)
    end

    def validate_params(file_dependency, file_lines, file_inspectors, file_requirements, file_inspections, file_formation_steps, file_procedures)
      if file_lines.blank? || file_lines.blank? || file_inspectors.blank? || file_requirements.blank? || file_inspections.blank? || file_formation_steps.blank? || file_procedures.blank?
        return false
      end
        return true
    end


  end
end