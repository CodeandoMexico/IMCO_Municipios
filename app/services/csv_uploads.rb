module CsvUploads

  def self.validate_dependencies(file_dependency,current_user)
    puts '"********** DEPENDENCIAS "**********'
    xml_contents =  load_file(file_dependency)
    if csv_empty?(xml_contents, "Dependency") && !xml_contents.nil?
      #puts "********** error al cargar CSV  dependencia**********"
      @errors << "Error al cargar el csv DEPENDENCIAS".mb_chars
      return false
    else
      number_of_successfully_created_rows = 0
        CSV.parse(xml_contents, :headers => true) do |row|
          city = City.find_by(name: row.to_hash['municipio'])
          name = row.to_hash['nombre']
          if city_validate?(city,current_user)
            row_values = { name: name, city: city }
            if row_does_not_exist_in_the_db(Dependency, row_values)
              Dependency.create!(row_values)
              number_of_successfully_created_rows += 1
            else
              #puts "********** DATO REPETIDO es omitido #{row_values} **********"
              #@log_array << {:warnings => "DATO REPETIDO  en DEPENDENCIAS es omitido #{row_values}".mb_chars}
              @warnings << "DATO REPETIDO  en DEPENDENCIAS es omitido #{row_values}".mb_chars
            end
          else
            #puts "********** Municipio incorrecto NO TIENES PERMISO **********"
            #@log_array << {:errors =>"Municipio incorrecto NO TIENES PERMISO".mb_chars}
            @errors << "Municipio incorrecto NO TIENES PERMISO".mb_chars
            return false
          end
        end
        #puts "********** Número satisfactorio de registros creados para (#{file_dependency.original_filename}): #{number_of_successfully_created_rows} **********"
        #@log_array << {:success =>"Número satisfactorio de registros creados para (#{file_dependency.original_filename}): #{number_of_successfully_created_rows}".mb_chars}
        @success << "Número satisfactorio de registros creados para (#{file_dependency.original_filename}): #{number_of_successfully_created_rows}".mb_chars
        if number_of_successfully_created_rows > 0
          return true
        end
      return false
    end
  end


  def self.validate_lines(file_lines,current_user)
    puts '"********** GIROS "**********'
    xml_contents =  load_file(file_lines)
    if csv_empty?(xml_contents, "line") && !xml_contents.nil?
      #puts "********** error al cargar CSV **********"
      @errors << "error al cargar csv GIROS".mb_chars
      return false
    else
      number_of_successfully_created_rows = 0
      CSV.parse(xml_contents, :headers => true) do |row|
        city = City.find_by(name: row.to_hash['municipio'])
        name = row.to_hash['nombre']
        description = row.to_hash['descripcion']
        if city_validate?(city,current_user)
          row_values = { name: name, city: city }
          if row_does_not_exist_in_the_db(Line, row_values)
            Line.create!(row_values)
            number_of_successfully_created_rows += 1
          else
            #puts "********** DATO REPETIDO es omitido #{row_values}  **********"
            @warnings << "DATO REPETIDO en GIROS es omitido #{row_values}".mb_chars
          end
        else
          #puts "********** Municipio incorrecto NO TIENES PERMISO **********"
          @errors << "Municipio incorrecto NO TIENES PERMISO".mb_chars
          return false
        end
      end
      #puts "********** Número satisfactorio de registros creados para (#{file_lines.original_filename}): #{number_of_successfully_created_rows} **********"
      @success << "Número satisfactorio de registros creados para (#{file_lines.original_filename}): #{number_of_successfully_created_rows}".mb_chars
      if number_of_successfully_created_rows > 0
        return true
      end
    return false
    end
  end


  def self.validate_inspectors(file_inspectors,city)
    puts '"********** INSPECTORES **********'
    xml_contents =  load_file(file_inspectors)
    if csv_empty?(xml_contents, "inspector") && !xml_contents.nil?
      #puts "********** error al cargar CSV **********"
      @errors << "error al cargar csv INSPECTORES".mb_chars
      return false
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
            #puts "********** DATO REPETIDO es omitido #{row_values} **********"
            @warnings << "DATO REPETIDO en INSPECTORES es omitido #{row_values}".mb_chars
          end
        else
          #puts "********** Una o más dependencias no coinciden, porfavor revisalos para continuar **********"
          @errors << "Una o más dependencias no coinciden en INSPECTORES, porfavor revisalos para continuar".mb_chars
          return false
        end
      end
      #puts "********** Número satisfactorio de registros creados para (#{file_inspectors.original_filename}): #{number_of_successfully_created_rows} **********"
      @success << " Número satisfactorio de registros creados para (#{file_inspectors.original_filename}): #{number_of_successfully_created_rows}".mb_chars
      if number_of_successfully_created_rows > 0
        return true
      end
    return false
    end
  end



  def self.validate_requirements(file_requirements,current_user)
    puts '"********** REQUISITOS **********'
    xml_contents =  load_file(file_requirements)
    if csv_empty?(xml_contents, "requirement") && !xml_contents.nil?
      #puts "********** error al cargar CSV **********"
      @errors << "error al cargar csv REQUISITOS".mb_chars
      return false
    else
      number_of_successfully_created_rows = 0
      CSV.parse(xml_contents, :headers => true) do |row|
        city = City.find_by(name: row.to_hash['municipio'])
        name = row.to_hash['nombre']
        description = row.to_hash['descripcion']
        path = row.to_hash['path']

        row_values = { name: name, city: city, description: description, path: path }
        if city_validate?(city,current_user)
          if row_does_not_exist_in_the_db(Requirement, row_values)
            Requirement.create!(row_values)
            number_of_successfully_created_rows += 1
          else
            @warnings << "DATO REPETIDO en REQUERIMIENTOS es omitido #{row_values}".mb_chars
          end
        else
          @errors << "Municipio incorrecto NO TIENES PERMISO".mb_chars
          return false
        end
      end
      #puts "********** Número satisfactorio de registros creados para (#{file_requirements.original_filename}): #{number_of_successfully_created_rows} **********"
      @success << "Número satisfactorio de registros creados para (#{file_requirements.original_filename}): #{number_of_successfully_created_rows}".mb_chars
      if number_of_successfully_created_rows > 0
          return true
        end
      return false
    end
  end


  def self.validate_inspections(file_inspections,city)
    puts '"********** INSPECCIONES **********'
    xml_contents =  load_file(file_inspections)
    if csv_empty?(xml_contents, "inspection") && !xml_contents.nil?
      #puts "********** error al cargar CSV **********"
      @errors << "error al cargar csv INSPECCIONES".mb_chars
      return false
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
                #puts "********** El giro: #{giro} no coincide con ninguno del dataset GIRO **********"
                @warnings << "El giro: #{giro} no coincide con ninguno del dataset GIRO, es omitido".mb_chars
              end
            end
              #puts "********** #{inspection_created.name} tiene Giros: #{number_of_successfully_created_giros} **********"
              @success << "#{inspection_created.name} tiene Giros: #{number_of_successfully_created_giros}".mb_chars
              number_of_successfully_created_requerimientos = 0
              requerimientos.split('; ').each do |requisito|
                unless Requirement.where(name: requisito, city_id: city).blank?
                  InspectionRequirement.create!(inspection_id: inspection_created.id, requirement_id: Requirement.where(name: requisito,city_id: city).first.id)
                  number_of_successfully_created_requerimientos += 1
                else
                  #puts "********** El requisito: #{requisito} no coincide con ninguno del dataset Requisito **********"
                  @warnings << "El requisito: #{requisito} no coincide con ninguno del dataset Requisito, es omitido".mb_chars
                end
              end
              #puts "********** #{inspection_created.name} tiene Requisitos: #{number_of_successfully_created_requerimientos} **********"
              @success << "#{inspection_created.name} tiene Requisitos: #{number_of_successfully_created_requerimientos}".mb_chars
              number_of_successfully_created_rows  += 1
          else
            @warnings << "DATO REPETIDO en INSPECCIONES es omitido #{row_values}".mb_chars
          end
        else
          #puts "********** Una o más dependencias no coinciden, porfavor revisalos para continuar **********"
          @errors << "Una o más dependencias  en INSPECCIONES no coinciden, porfavor revisalos para continuar".mb_chars
          return false
        end 
      end
      #puts "********** Número satisfactorio de registros creados para (#{file_inspections.original_filename}): #{number_of_successfully_created_rows} **********"
      @success << "Número satisfactorio de registros creados para (#{file_inspections.original_filename}): #{number_of_successfully_created_rows}".mb_chars
      if number_of_successfully_created_rows > 0
        return true
      end
      return false
    end
  end


  def self.validate_formation_steps(file_formation_steps,current_user)
    puts '"********** TRAMITES DE APERTURA **********'
    xml_contents =  load_file(file_formation_steps)
    if csv_empty?(xml_contents, "formation_steps") && !xml_contents.nil?
      #puts "********** error al cargar CSV **********"
      @errors << "error al cargar csv TRÁMITES DE APERTURA".mb_chars
      return false
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
      
      if city_validate?(city,current_user)
        if row_does_not_exist_in_the_db(FormationStep, row_values)
          FormationStep.create!(row_values)
          number_of_successfully_created_rows += 1
        else
          @warnings << "DATO REPETIDO en TRÁMITES DE APERTURA es omitido #{row_values}".mb_chars
        end
      else
        @errors << "Municipio incorrecto NO TIENES PERMISO".mb_chars
        return false
      end
    end
    #puts "********** Número satisfactorio de registros creados para (#{file_formation_steps.original_filename}): #{number_of_successfully_created_rows} **********"
    @success << "Número satisfactorio de registros creados para (#{file_formation_steps.original_filename}): #{number_of_successfully_created_rows}".mb_chars
    if number_of_successfully_created_rows > 0
      return true
    end
    return false
    end
  end



  def self.validate_procedures(file_procedures, city)
    puts '"********** TRAMITES **********'
    xml_contents =  load_file(file_procedures)
    if csv_empty?(xml_contents, "procedures") && !xml_contents.nil?
      #puts "********** error al cargar CSV **********"
      @errors << "error al cargar csv TRÁMITES".mb_chars
      return false
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
                @warnings << "El giro: #{giro} no coincide con ninguno del dataset GIRO es omitido".mb_chars
              end
            end
            #puts  "#{procedure_created.name} tiene Giros: #{number_of_successfully_created_giros}"
            @success << "#{procedure_created.name} tiene Giros: #{number_of_successfully_created_giros}".mb_chars
            number_of_successfully_created_requerimientos = 0
            tramites.split('; ').each do |requisito|
              unless Requirement.where(name: requisito, city_id: city).blank?
                ProcedureRequirement.create(procedure_id: procedure_created.id, requirement_id: Requirement.where(name: requisito, city_id: city).first.id)
                number_of_successfully_created_requerimientos += 1
              else
                @warnings << "El requisito: #{requisito} no coincide con ninguno del dataset Requisito, es omitido".mb_chars
              end
            end
            #puts "#{procedure_created.name} tiene Requisitos: #{number_of_successfully_created_requerimientos}"
            @success << "#{procedure_created.name} tiene Requisitos: #{number_of_successfully_created_requerimientos}".mb_chars
            number_of_successfully_created_rows +=  1
          else
            @warnings << "DATO REPETIDO en TRAMITES es omitido #{row_values}".mb_chars
          end
        else
          #puts "********** Una o más dependencias no coinciden, porfavor revisalos para continuar **********"
          @errors << "Una o más dependencias  en INSPECCIONES no coinciden, porfavor revisalos para continuar".mb_chars
          return false
        end 
      end
      #puts "********** Número satisfactorio de registros creados para (#{file_procedures.original_filename}): #{number_of_successfully_created_rows} **********"
      @success << "Número satisfactorio de registros creados para (#{file_procedures.original_filename}): #{number_of_successfully_created_rows}".mb_chars
      if number_of_successfully_created_rows > 0
        return true
      end
      return false
    end
  end



  def self.csv_empty?(file, name)
    if CSV.new(file, headers: :first_row).to_a.empty?
      #puts "********** CSV esta vacio **********"
      @errors << "El csv referente a #{file.class.name} están vacios".mb_chars
      return true
    else
      unless has_headers?(file,name)
        @errors << "El csv referente a #{file.class.name} no tienen las cabeceras correctas".mb_chars
        #puts "********** CSV no tiene las cabeceras correctas **********"
        return  true
      else
        return false
      end
    end
    return false
  end

  def self.row_does_not_exist_in_the_db(model, search_values)
    !model.where(search_values).present?
  end


  def self.city_validate?(city, current_user)
   city.present? && current_user.city_id == city.id
  end

  def self.load_file(file)
    xml_contents = nil
    if file.respond_to?(:read)
      xml_contents = file.read
    elsif file.respond_to?(:path)
      xml_contents = File.read(file.path)
    else
      #puts "********** El archivo de dependencias está incorrecto: #{file.class.name}: #{file.inspect} **********"
      @errors << "El archivo #{file.class.name} está incorrecto: #{file.inspect}".mb_chars
    end
    return xml_contents
  end

  def self.delete_all_data(city, file_success)

    #abrir files a utilizar
    #llenar y cerrar
    #archivo termina con @@@@

    puts '********** Borrando Todos los Datasets **********'
   
    inspector = Inspector.by_city(City.find(city))
    unless inspector.blank?
      inspector.each do |inspector|
        inspector.delete
      end 
    end
    puts '********** Inspectores borrados **********'

    inspection = Inspection.by_city(City.find(city))
    unless inspection.blank?
      inspection.each do |inspection|
        inspection.delete
      end 
    end
    puts '********** Inspection borrados **********'

    procedure = Procedure.by_city(City.find(city))
    unless procedure.blank?
      procedure.each do |procedure|
        procedure.delete
      end 
    end
    puts '********** Tramites borrados **********'

    Dependency.where(city_id: city).delete_all
    puts '********** Dependencias borradas **********' 
    
    Line.where(city_id: city).delete_all
    puts '********** Giros borrados **********' 

    Requirement.where(city_id: city).delete_all
    puts '********** Requisitos borrados **********'

    FormationStep.where(city_id: city).delete_all
    puts '********** Tramites apertura borrados **********' 

    file_success.puts("Base de datos borrada satisfactoriamente".mb_chars)
  end


  def self.has_headers?(file, name)
    headers = CSV.parse(file)
    case name
      when 'Dependency'
        puts '********** validando cabeceras dependencia **********'
        return headers[0].include?('nombre') && headers[0].include?('municipio')
      when 'line'
        '********** validando cabeceras giros **********'
        return headers[0].include?('nombre') && headers[0].include?('municipio') && headers[0].include?('descripcion')
      when 'inspector'
        '********** validando cabeceras inspectores **********'
        return headers[0].include?('dependencia') && headers[0].include?('nombre') && headers[0].include?('vigencia') && headers[0].include?('materia') && headers[0].include?('supervisor') && headers[0].include?('contacto') && headers[0].include?('foto')
      when 'requirement'
        '********** validando cabeceras Requisitos **********'
        return headers[0].include?('nombre') && headers[0].include?('municipio') && headers[0].include?('descripcion') && headers[0].include?('path')
      when 'inspection'
        '********** validando cabeceras inspectores **********'
        return headers[0].include?('dependencia') && headers[0].include?('nombre') && headers[0].include?('materia') && headers[0].include?('duracion') && headers[0].include?('norma') && headers[0].include?('antes') && headers[0].include?('durante') && headers[0].include?('despues') && headers[0].include?('sancion') && headers[0].include?('giros') && headers[0].include?('requerimientos')
      when 'formation_steps'
        '********** validando cabeceras tramites de apertura **********'
        return headers[0].include?('municipio') && headers[0].include?('nombre') && headers[0].include?('descripcion') && headers[0].include?('path') && headers[0].include?('tipo') && headers[0].include?('tramite') 
      when 'procedures'
        '********** validando cabeceras tramites **********'
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