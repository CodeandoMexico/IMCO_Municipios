class LoadWorker

  include Sidekiq::Worker

  def perform(current_user_id,city,file_dependency, file_lines, file_inspectors, file_requirements, file_inspections, file_formation_steps, file_procedures)
    id_user = fill_user_id(current_user_id)
    @status = Uploads.where(id_user: id_user).last

  if @status.status == "iniciado"
    id_city = fill_city_id(city)
    
    CsvUploads.delete_all_data(id_city,id_user)
     if CsvUploads.validate_dependencies(file_dependency,id_user) && 
        CsvUploads.validate_lines(file_lines,id_user) && 
        CsvUploads.validate_inspectors(file_inspectors,id_city,id_user) && 
        CsvUploads.validate_requirements(file_requirements,id_user) && 
        CsvUploads.validate_inspections(file_inspections,id_city,id_user) && 
        CsvUploads.validate_formation_steps(file_formation_steps,id_user) &&
        CsvUploads.validate_procedures(file_procedures,id_city,id_user)

        file_success = File.open("lib/temp/upload_#{current_user_id}/success.txt","a")
        file_success.puts("Éxito@General@Datasets cargados con éxito.".mb_chars)
        file_success.close
     else
        file_errors = File.open("lib/temp/upload_#{current_user_id}/errors.txt","a")
        file_errors.puts("Error@General@Fallo con los datasets, porfavor revisalos e intenta de nuevo.".mb_chars)
        file_errors.close
        CsvUploads.delete_all_data(id_city,id_user)
     end
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