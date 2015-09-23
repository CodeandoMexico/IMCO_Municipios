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
          CsvUploads.delete_all_data(@city)

          if CsvUploads.validate_dependencies(file_dependency,current_user) && 
            CsvUploads.validate_lines(file_lines,current_user) && 
            CsvUploads.validate_inspectors(file_inspectors,@city) && 
            CsvUploads.validate_requirements(file_requirements,current_user) && 
            CsvUploads.validate_inspections(file_inspections,@city) && 
            CsvUploads.validate_formation_steps(file_formation_steps,current_user) &&
            CsvUploads.validate_procedures(file_procedures,@city)

            puts '***************'
            puts $errors.size
            puts $warnings.size
            puts $success.size

            redirect_to upload_dashboard_path,  notice:  "Datasets cargados con éxito"

          else
            CsvUploads.delete_all_data(@city)
            redirect_to upload_dashboard_path,  error:  "Revice los errores marcados, NINGUN CAMBIO FUE EFECTUADO"
          end
        else
          redirect_to upload_dashboard_path,  error:  "Debes agregar todos los datasets  NINGUN CAMBIO FUE EFECTUADO"
        end
      else
        redirect_to upload_dashboard_path,  error:  "Debes agregar todos los datasets  NINGUN CAMBIO FUE EFECTUADO"
      end

    end



    private

    def set_city
      $errors = []
      $warnings = []
      $success = []
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