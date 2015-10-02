class LoadWorker
  include Sidekiq::Worker
  def perform(current_user, city,file_dependency, file_lines, file_inspectors, file_requirements, file_inspections, file_formation_steps, file_procedures)
   	if CsvUploads.validate_dependencies(file_dependency,current_user) && 
        CsvUploads.validate_lines(file_lines,current_user) && 
        CsvUploads.validate_inspectors(file_inspectors,city) && 
        CsvUploads.validate_requirements(file_requirements,current_user) && 
        CsvUploads.validate_inspections(file_inspections,city) && 
        CsvUploads.validate_formation_steps(file_formation_steps,current_user) &&
        CsvUploads.validate_procedures(file_procedures,city)
        $success << "************ Datasets cargados con éxito ************"
        redirect_to upload_dashboard_path,  notice:  "Datasets cargados con éxito"
    else
        CsvUploads.delete_all_data(city)
        $errors << "************ Revisa los errores para que puedas ingresar los datos nuevos. ************"
        redirect_to upload_dashboard_path,  error:  "Revise los errores marcados, NINGUN CAMBIO FUE EFECTUADO"
    end
  end  
end