module Dashboard
  class CitiesController < ApplicationController
    before_filter :set_city
    layout 'dashboard'

    def update
      file_dependency = params[:post][:dependency_file]
      file_lines = params[:post][:line_file]
      file_inspectors = params[:post][:inspector_file]
      file_requirements = params[:post][:requirement_file]
      file_inspections = params[:post][:inspection_file]
      file_formation_steps = params[:post][:formation_step_file]
      file_procedures = params[:post][:procedure_file]

      CsvUploads.delete_all_data(@city)

      if CsvUploads.validate_dependencies(file_dependency,current_user) && 
        CsvUploads.validate_lines(file_lines,current_user) && 
        CsvUploads.validate_inspectors(file_inspectors,@city) && 
        CsvUploads.validate_requirements(file_requirements,current_user) && 
        CsvUploads.validate_inspections(file_inspections,@city) && 
        CsvUploads.validate_formation_steps(file_formation_steps,current_user) &&
        CsvUploads.validate_procedures(file_procedures,@city)


        puts '********** Datasets cargados con éxito **********'
      else
        puts '********** Revice los errores marcados, NINGUN CAMBIO FUE EFECTUADO **********'
        CsvUploads.delete_all_data(@city)
      end
    end



    private

    def set_city
      @city ||= City.find(current_user.city_id)
    end


  end
end