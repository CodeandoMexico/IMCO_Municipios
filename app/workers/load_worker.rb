class LoadWorker

  include Sidekiq::Worker

  def perform(current_user_id,city,file_dependency, file_lines, file_inspectors, file_requirements, file_inspections, file_formation_steps, file_procedures)
    id_user = fill_user_id(current_user_id)
    id_city = fill_city_id(city)
    @status = Uploads.where(id_user: id_user).last

    CsvUploads.delete_all_data(id_city,id_user)
   	 if CsvUploads.validate_dependencies(file_dependency,id_user) && 
        CsvUploads.validate_lines(file_lines,id_user) && 
        CsvUploads.validate_inspectors(file_inspectors,id_city,id_user) && 
        CsvUploads.validate_requirements(file_requirements,id_user) && 
        CsvUploads.validate_inspections(file_inspections,id_city,id_user) && 
        CsvUploads.validate_formation_steps(file_formation_steps,id_user) &&
        CsvUploads.validate_procedures(file_procedures,id_city,id_user)
         puts "************ Datasets cargados con éxito ************"
     else
        puts "************ Datasets NO cargados por ERRORES ************"
        CsvUploads.delete_all_data(id_city,id_user)
     end
    
    @status.status = "terminado"
    if @status.save
      puts '*******************Status Terminado*****************'
    end

  end 

  def fill_user_id(current_user_id)
     if current_user_id.is_a? Numeric
       return current_user_id
      else
       return User.where(email: current_user_id).last.id
     end
   end 

  def fill_city_id(city)
     if city.is_a? Numeric
       return city
      else
       return city.id
     end
   end

end