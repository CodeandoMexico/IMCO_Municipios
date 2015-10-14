module CsvUploads

  def self.validate_dependencies(file_dependency,current_user_id)
    puts '"********** DEPENDENCIAS "**********'
    file_errors = File.open("lib/temp/upload_#{current_user_id}/errors.txt","a")
    file_success = File.open("lib/temp/upload_#{current_user_id}/success.txt","a")
    file_warnings = File.open("lib/temp/upload_#{current_user_id}/warnings.txt","a")
    returned = false
    name_file = "Dependencias"

    xml_contents =  load_file(file_dependency,current_user_id)
    if csv_empty?(xml_contents, name_file,current_user_id) && !xml_contents.nil?
      file_errors.puts("Error@#{name_file}@No se pudo leer el CSV".mb_chars)
      returned = false
    else
      number_of_successfully_created_rows = 0
      CSV.parse(xml_contents, :headers => true) do |row|
        city = City.find_by(name: row.to_hash['municipio'])
        name = row.to_hash['nombre']
        if city_validate?(city,current_user_id)
          row_values = { name: name, city: city }
          if row_does_not_exist_in_the_db(Dependency, row_values)
            Dependency.create!(row_values)
            number_of_successfully_created_rows += 1
          else
             file_warnings.puts("Adverteincia@#{name_file}@#{row_values[:name]} ya existe, al ser repetido es omitido".mb_chars)
          end
        else
          file_errors.puts("Error@#{name_file}@Municipio incorrecto NO TIENES PERMISO para crear o modificar otro municipio".mb_chars)
          returned = false
        end
      end
      file_success.puts("Éxito@#{name_file}@Número satisfactorio de registros creados: #{number_of_successfully_created_rows}".mb_chars)
      if number_of_successfully_created_rows > 0
        returned = true
      end
    end
    
    file_errors.close
    file_success.close
    file_warnings.close
    return returned
  end


  def self.validate_lines(file_lines,current_user_id)
    puts '"********** GIROS "**********'
    file_errors = File.open("lib/temp/upload_#{current_user_id}/errors.txt","a")
    file_success = File.open("lib/temp/upload_#{current_user_id}/success.txt","a")
    file_warnings = File.open("lib/temp/upload_#{current_user_id}/warnings.txt","a")
    returned = false
    name_file = "Giros"

    xml_contents =  load_file(file_lines,current_user_id)
    if csv_empty?(xml_contents, name_file,current_user_id) && !xml_contents.nil?
      file_errors.puts("Error@#{name_file}@No se pudo leer el CSV".mb_chars)
      returned = false
    else
      number_of_successfully_created_rows = 0
      CSV.parse(xml_contents, :headers => true) do |row|
        city = City.find_by(name: row.to_hash['municipio'])
        name = row.to_hash['nombre']
        description = row.to_hash['descripcion']
        if city_validate?(city,current_user_id)
          row_values = { name: name, city: city }
          if row_does_not_exist_in_the_db(Line, row_values)
            Line.create!(row_values)
            number_of_successfully_created_rows += 1
          else
            file_warnings.puts("Adverteincia@#{name_file}@#{row_values[:name]} ya existe, al ser repetido es omitido".mb_chars)
          end
        else
          file_errors.puts("Error@#{name_file}@Municipio incorrecto NO TIENES PERMISO para crear o modificar otro municipio".mb_chars)
          returned = false
        end
      end
      file_success.puts("Éxito@#{name_file}@Número satisfactorio de registros creados: #{number_of_successfully_created_rows}".mb_chars)
      if number_of_successfully_created_rows > 0
        returned = true
      end
    end
    file_errors.close
    file_success.close
    file_warnings.close
    return returned
  end


  def self.validate_inspectors(file_inspectors,city,current_user_id)
    puts '"********** INSPECTORES **********'
    file_errors = File.open("lib/temp/upload_#{current_user_id}/errors.txt","a")
    file_success = File.open("lib/temp/upload_#{current_user_id}/success.txt","a")
    file_warnings = File.open("lib/temp/upload_#{current_user_id}/warnings.txt","a")
    returned = false
    name_file = "Inspectores"

    xml_contents =  load_file(file_inspectors,current_user_id)
    if csv_empty?(xml_contents, name_file,current_user_id) && !xml_contents.nil?
      file_errors.puts("Error@#{name_file}@No se pudo leer el CSV".mb_chars)
      returned = false
    else
      number_of_successfully_created_rows = 0
      CSV.parse(xml_contents, :headers => true) do |row|
        dependency = Dependency.find_by(name: row.to_hash['dependencia'], city_id: city)
        name = row.to_hash['nombre']
        valid_through = row.to_hash['vigencia']
        subject = row.to_hash['materia']
        supervisor = row.to_hash['supervisor']
        contact = row.to_hash['contacto']
        photo = row.to_hash['foto']
        unless dependency.blank?
          row_values = {dependency: dependency, name: name, validity: valid_through, matter: subject, supervisor: supervisor, photo: photo, contact: contact}
          if  row_does_not_exist_in_the_db(Inspector, row_values)
            Inspector.create!(row_values)
            number_of_successfully_created_rows += 1
          else
            file_warnings.puts("Adverteincia@#{name_file}@#{row_values[:name]} ya existe, al ser repetido es omitido".mb_chars)
          end
        else
          file_errors.puts("Error@#{name_file}@Municipio incorrecto NO TIENES PERMISO para crear o modificar otro municipio".mb_chars)
          returned = false
        end
      end
       file_success.puts("Éxito@#{name_file}@Número satisfactorio de registros creados: #{number_of_successfully_created_rows}".mb_chars)
      if number_of_successfully_created_rows > 0
        returned = true
      end
    end

    file_errors.close
    file_success.close
    file_warnings.close
    return returned
  end



  def self.validate_requirements(file_requirements,current_user_id)
    puts '"********** REQUISITOS **********'
    file_errors = File.open("lib/temp/upload_#{current_user_id}/errors.txt","a")
    file_success = File.open("lib/temp/upload_#{current_user_id}/success.txt","a")
    file_warnings = File.open("lib/temp/upload_#{current_user_id}/warnings.txt","a")
    returned = false
    name_file = "Requerimientos"

    xml_contents =  load_file(file_requirements,current_user_id)
    if csv_empty?(xml_contents, name_file,current_user_id) && !xml_contents.nil?
      file_errors.puts("Error@#{name_file}@No se pudo leer el CSV".mb_chars)
      returned = false
    else
      number_of_successfully_created_rows = 0
      CSV.parse(xml_contents, :headers => true) do |row|
        city = City.find_by(name: row.to_hash['municipio'])
        name = row.to_hash['nombre']
        description = row.to_hash['descripcion']
        path = row.to_hash['path']

        row_values = { name: name, city: city, description: description, path: path }
        if city_validate?(city,current_user_id)
          if row_does_not_exist_in_the_db(Requirement, row_values)
            Requirement.create!(row_values)
            number_of_successfully_created_rows += 1
          else
            file_warnings.puts("Adverteincia@#{name_file}@#{row_values[:name]} ya existe, al ser repetido es omitido".mb_chars)
          end
        else
          file_errors.puts("Error@#{name_file}@Municipio incorrecto NO TIENES PERMISO para crear o modificar otro municipio".mb_chars)
          returned = false
        end
      end
      file_success.puts("Éxito@#{name_file}@Número satisfactorio de registros creados: #{number_of_successfully_created_rows}".mb_chars)
      if number_of_successfully_created_rows > 0
          returned = true
        end
    end

    file_errors.close
    file_success.close
    file_warnings.close
    return returned
  end


  def self.validate_inspections(file_inspections,city,current_user_id)
    puts '"********** INSPECCIONES **********'
    file_errors = File.open("lib/temp/upload_#{current_user_id}/errors.txt","a")
    file_success = File.open("lib/temp/upload_#{current_user_id}/success.txt","a")
    file_warnings = File.open("lib/temp/upload_#{current_user_id}/warnings.txt","a")
    returned = false
    name_file = "Inspecciones"

    xml_contents =  load_file(file_inspections,current_user_id)
    if csv_empty?(xml_contents, name_file,current_user_id) && !xml_contents.nil?
      file_errors.puts("Error@#{name_file}@No se pudo leer el CSV".mb_chars)
      returned = false
    else
      number_of_successfully_created_rows = 0
      CSV.parse(xml_contents, :headers => true) do |row|
        dependency = Dependency.find_by(name: row.to_hash['dependencia'], city_id: city)
        name = row.to_hash['nombre']
        subject = row.to_hash['materia']
        period = row.to_hash['duracion']
        norm = row.to_hash['norma']
        before_tips = row.to_hash['antes']
        during_tips = row.to_hash['durante']
        after_tips = row.to_hash['despues']
        sanctions = row.to_hash['sancion']
        certification = row.to_hash['documento_acredita']
        giros = row.to_hash['giros']
        requerimientos = row.to_hash['requerimientos']

        unless dependency.blank? 
          row_values = {dependency: dependency,name: name,matter: subject,duration: period,rule: norm,before: before_tips,during: during_tips,after: after_tips,sanction: sanctions,certification: certification}
          if row_does_not_exist_in_the_db(Inspection, row_values)
            inspection_created =  Inspection.create(row_values)
            number_of_successfully_created_giros = 0
            giros.split('; ').each do |giro|
              unless Line.where(name: giro, city_id: city).blank?
                InspectionLine.create!(inspection_id: inspection_created.id, line_id: Line.where(name: giro, city_id: city).first.id)
                number_of_successfully_created_giros += 1
              else
                file_warnings.puts("Adverteincia@#{name_file}@El giro: #{giro} no coincide con ninguno del dataset GIROS, es omitido".mb_chars)
              end
            end
              file_success.puts("Éxito@#{name_file}@#{inspection_created.name} cuenta con: #{number_of_successfully_created_giros} GIROS".mb_chars)
              number_of_successfully_created_requerimientos = 0
              requerimientos.split('; ').each do |requisito|
                unless Requirement.where(name: requisito, city_id: city).blank?
                  InspectionRequirement.create!(inspection_id: inspection_created.id, requirement_id: Requirement.where(name: requisito,city_id: city).first.id)
                  number_of_successfully_created_requerimientos += 1
                else
                  file_warnings.puts("Adverteincia@#{name_file}@El requisito: #{requisito} no coincide con ninguno del dataset REQUERIMIENTOS, es omitido".mb_chars)
                end
              end
              file_success.puts("Éxito@#{name_file}@#{inspection_created.name} cuenta con: #{number_of_successfully_created_requerimientos} REQUERIMIENTOS".mb_chars)
              number_of_successfully_created_rows  += 1
          else
            file_warnings.puts("Adverteincia@#{name_file}@#{row_values[:name]} ya existe, al ser repetido es omitido".mb_chars)
          end
        else
          file_errors.puts("Error@#{name_file}@Una o más dependencias no existen en el dataset DEPENDENCIAS, porfavor revisalos y vuelve a hacer la carga.".mb_chars)
          returned = false
        end 
      end
      file_success.puts("Éxito@#{name_file}@Número satisfactorio de registros creados: #{number_of_successfully_created_rows}".mb_chars)
      if number_of_successfully_created_rows > 0
        returned = true
      end
    end

    file_errors.close
    file_success.close
    file_warnings.close
    return returned
  end



  def self.validate_formation_steps(file_formation_steps,current_user_id)
    puts '"********** TRAMITES DE APERTURA **********'
    file_errors = File.open("lib/temp/upload_#{current_user_id}/errors.txt","a")
    file_success = File.open("lib/temp/upload_#{current_user_id}/success.txt","a")
    file_warnings = File.open("lib/temp/upload_#{current_user_id}/warnings.txt","a")
    returned = false
    name_file = "Tramites de apertura"

    xml_contents =  load_file(file_formation_steps,current_user_id)
    if csv_empty?(xml_contents, name_file,current_user_id) && !xml_contents.nil?
      file_errors.puts("Error@#{name_file}@No se pudo leer el CSV".mb_chars)
      returned =  false
    else
      number_of_successfully_created_rows = 0
      CSV.parse(xml_contents, :headers => true) do |row|
        city = City.find_by(name: row.to_hash['municipio'])
        name = row.to_hash['nombre']
        description = row.to_hash['descripcion']
        path = row.to_hash['path']
        type = getTipoApertura(row.to_hash['tipo'])
        type_of_procedure = row.to_hash['tramite']
        row_values = { name: name, city: city, description: description, path: path, type_formation_step: type, type_of_procedure:  type_of_procedure}
      
        if city_validate?(city,current_user_id)
          if row_does_not_exist_in_the_db(FormationStep, row_values)
            FormationStep.create!(row_values)
            number_of_successfully_created_rows += 1
          else
            file_warnings.puts("Adverteincia@#{name_file}@#{row_values[:name]} ya existe, al ser repetido es omitido".mb_chars)
          end
        else
          file_errors.puts("Error@#{name_file}@Municipio incorrecto NO TIENES PERMISO para crear o modificar otro municipio".mb_chars)
          returned =  false
        end
      end
      file_success.puts("Éxito@#{name_file}@Número satisfactorio de registros creados: #{number_of_successfully_created_rows}".mb_chars)
      if number_of_successfully_created_rows > 0
        returned =  true
      end
    end

    file_errors.close
    file_success.close
    file_warnings.close
    return returned
  end




  def self.validate_procedures(file_procedures, city,current_user_id)
    puts '"********** validate_procedures **********'
    file_errors = File.open("lib/temp/upload_#{current_user_id}/errors.txt","a")
    file_success = File.open("lib/temp/upload_#{current_user_id}/success.txt","a")
    file_warnings = File.open("lib/temp/upload_#{current_user_id}/warnings.txt","a")
    returned = false

    xml_contents =  load_file(file_procedures,current_user_id)
    if csv_empty?(xml_contents, "procedures",current_user_id) && !xml_contents.nil?
      file_errors.puts("Error@#{name_file}@No se pudo leer el CSV".mb_chars)
      returned = false
    else
      number_of_successfully_created_rows = 0
      CSV.parse(xml_contents, :headers => true) do |row|
        dependency = Dependency.find_by(name: row.to_hash['dependencia'], city_id: city)
        name = row.to_hash['nombre']
        time = row.to_hash['duracion']
        cost = row.to_hash['costo']
        supervisor = row.to_hash['vigencia']
        contact = row.to_hash['contacto']
        tipo = row.to_hash['tipo']
        giros = row.to_hash['giros']
        tramites = row.to_hash['tramites']
        categoria = row.to_hash['categoria']
        sare = row.to_hash['sare']

        row_values = { dependency: dependency, name: name, long: time, cost: cost, validity: supervisor, contact: contact, type_procedure: getTipo(tipo), category: categoria, sare: sare}      
      
        unless dependency.blank?
          if row_does_not_exist_in_the_db(Procedure, row_values)
            procedure_created =  Procedure.create!(row_values)
            number_of_successfully_created_giros = 0
            giros.split('; ').each do |giro|
              unless Line.where(name: giro, city_id: city).blank?
                ProcedureLine.create(procedure_id: procedure_created.id, line_id: Line.where(name: giro, city_id: city).first.id)
                number_of_successfully_created_giros += 1
              else
                file_warnings.puts("El giro: #{giro} no coincide con ninguno del dataset GIRO es omitido".mb_chars)
              end
            end
            file_success.puts("#{procedure_created.name} tiene Giros: #{number_of_successfully_created_giros}".mb_chars)
            number_of_successfully_created_requerimientos = 0
            tramites.split('; ').each do |requisito|
              unless Requirement.where(name: requisito, city_id: city).blank?
                ProcedureRequirement.create(procedure_id: procedure_created.id, requirement_id: Requirement.where(name: requisito, city_id: city).first.id)
                number_of_successfully_created_requerimientos += 1
              else
                file_warnings.puts("El requisito: #{requisito} no coincide con ninguno del dataset Requisito, es omitido".mb_chars)
              end
            end
            file_success.puts("#{procedure_created.name} tiene Requisitos: #{number_of_successfully_created_requerimientos}".mb_chars)
            number_of_successfully_created_rows +=  1
          else
            file_warnings.puts("DATO REPETIDO en TRAMITES es omitido #{row_values}".mb_chars)
          end
        else
          file_errors.puts("Una o más dependencias  en INSPECCIONES no coinciden, porfavor revisalos para continuar".mb_chars)
          returned = false
        end 
      end
      file_success.puts("Número satisfactorio de registros creados para Tramites: #{number_of_successfully_created_rows}".mb_chars)
      if number_of_successfully_created_rows > 0
        returned = true
      end
    end

    file_errors.close
    file_success.close
    file_warnings.close
    return returned
  end




  def self.csv_empty?(file, name, current_user_id)
    file_errors = File.open("lib/temp/upload_#{current_user_id}/errors.txt","a")

    returned = false
    if CSV.new(file, headers: :first_row).to_a.empty?
      file_errors.puts("Error@#{name}@El csv está vacio".mb_chars)
      returned =  true
    else
      unless has_headers?(file,name)
        file_errors.puts("Error@#{name}@El csv no tienen las cabeceras correctas".mb_chars)
        returned =  true
      else
        returned = false
      end
    end
    
    file_errors.close
    return returned
  end



  def self.row_does_not_exist_in_the_db(model, search_values)
    !model.where(search_values).present?
  end




  def self.city_validate?(city, current_user_id)
    User.find(current_user_id).city_id == city.id
  end




  def self.delete_all_data(city,current_user_id)
    file_success = File.open("lib/temp/upload_#{current_user_id}/success.txt","a")
   
    inspector = Inspector.by_city(City.find(city))
    unless inspector.blank?
      inspector.each do |inspector|
        inspector.delete
      end 
    end

    inspection = Inspection.by_city(City.find(city))
    unless inspection.blank?
      inspection.each do |inspection|
        inspection.delete
      end 
    end

    procedure = Procedure.by_city(City.find(city))
    unless procedure.blank?
      procedure.each do |procedure|
        procedure.delete
      end 
    end

    Dependency.where(city_id: city).delete_all
    
    Line.where(city_id: city).delete_all

    Requirement.where(city_id: city).delete_all

    FormationStep.where(city_id: city).delete_all

    file_success.puts("Base de datos borrada satisfactoriamente".mb_chars)
    file_success.close
  end


    def self.load_file(file,current_user_id)
    xml_contents = nil
    if file.respond_to?(:read)
      xml_contents = file.read
    elsif file.respond_to?(:path)
      xml_contents = File.read(file.path)
    else
        xml_contents = File.read(file)
    end
    return xml_contents
  end


  def self.has_headers?(file, name)
    headers = CSV.parse(file)
    case name
      when 'Dependencias'
        return headers[0].include?('nombre') && headers[0].include?('municipio')
      when 'Giros'
        return headers[0].include?('nombre') && headers[0].include?('municipio') && headers[0].include?('descripcion')
      when 'Inspectores'
        return headers[0].include?('dependencia') && headers[0].include?('nombre') && headers[0].include?('vigencia') && headers[0].include?('materia') && headers[0].include?('supervisor') && headers[0].include?('contacto') && headers[0].include?('foto')
      when 'Requerimientos'
        return headers[0].include?('nombre') && headers[0].include?('municipio') && headers[0].include?('descripcion') && headers[0].include?('path')
      when 'Inspecciones'
        return headers[0].include?('dependencia') && headers[0].include?('nombre') && headers[0].include?('materia') && headers[0].include?('duracion') && headers[0].include?('norma') && headers[0].include?('antes') && headers[0].include?('durante') && headers[0].include?('despues') && headers[0].include?('sancion') && headers[0].include?('giros') && headers[0].include?('requerimientos')
      when 'Tramites de apertura'
        return headers[0].include?('municipio') && headers[0].include?('nombre') && headers[0].include?('descripcion') && headers[0].include?('path') && headers[0].include?('tipo') && headers[0].include?('tramite') 
      when 'procedures'
        return headers[0].include?('dependencia') && headers[0].include?('nombre') && headers[0].include?('duracion') && headers[0].include?('costo') && headers[0].include?('vigencia') && headers[0].include?('contacto') && headers[0].include?('tipo') && headers[0].include?('giros') && headers[0].include?('tramites') && headers[0].include?('categoria') && headers[0].include?('sare') 
      end  
    return false
  end





  def self.getTipo(tipo)
    if tipo == 'Física'
      'TF'
    elsif tipo == 'Moral'
      'TM'
    else
      'A'
    end
  end




  def self.getTipoApertura(tipo)
    if tipo == 'Física'
      'AF'
    elsif tipo == 'Moral'
      'AM'
    else
      'A'
    end
  end

end