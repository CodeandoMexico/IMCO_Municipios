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

      delete_all_data

      if validate_dependencies(file_dependency) && validate_lines(file_lines) && validate_inspectors(file_inspectors) && validate_requirements(file_requirements) && validate_inspections(file_inspections)

      else
        puts '********** Revice los errores marcados, NINGUN CAMBIO FUE EFECTUADO **********'
        delete_all_data
      end
    end



    private

    def validate_dependencies(file_dependency)
      puts '"********** DEPENDENCIAS "**********'
      xml_contents =  load_file(file_dependency)
      if csv_empty?(xml_contents, "Dependency") && !xml_contents.nil?
        puts "********** error al cargar CSV **********"
        return false
      else
        number_of_successfully_created_rows = 0
          CSV.parse(xml_contents, :headers => true) do |row|
            city = City.find_by(name: row.to_hash['municipio'])
            name = row.to_hash['nombre']
            if city_validate?(city)
              row_values = { name: name, city: city }
              if row_does_not_exist_in_the_db(Dependency, row_values)
                Dependency.create!(row_values)
                puts '.'
                number_of_successfully_created_rows += 1
              else
                puts "********** DATO REPETIDO será omitido #{row_values} **********"
              end
            else
              puts "********** Municipio incorrecto NO TIENES PERMISO **********"
              return false
            end
          end
          puts "********** Número satisfactorio de registros creados para (#{file_dependency.original_filename}): #{number_of_successfully_created_rows} **********"
          if number_of_successfully_created_rows > 0
            return true
          end
        return false
      end
    end


    def validate_lines(file_lines)
      puts '"********** GIROS "**********'
      xml_contents =  load_file(file_lines)
      if csv_empty?(xml_contents, "line") && !xml_contents.nil?
        puts "********** error al cargar CSV **********"
        return false
      else
        number_of_successfully_created_rows = 0
        CSV.parse(xml_contents, :headers => true) do |row|
          city = City.find_by(name: row.to_hash['municipio'])
          name = row.to_hash['nombre']
          description = row.to_hash['descripcion']
          if city_validate?(city)
            row_values = { name: name, city: city }
            if row_does_not_exist_in_the_db(Line, row_values)
              Line.create!(row_values)
              puts '.'
              number_of_successfully_created_rows += 1
            else
              puts "********** DATO REPETIDO será omitido #{row_values}  **********"
            end
          else
            puts "********** Municipio incorrecto NO TIENES PERMISO **********"
            return false
          end
        end
        puts "********** Número satisfactorio de registros creados para (#{file_lines.original_filename}): #{number_of_successfully_created_rows} **********"
        if number_of_successfully_created_rows > 0
          return true
        end
      return false
      end
    end


    def validate_inspectors(file_inspectors)
      puts '"********** INSPECTORES **********'
      xml_contents =  load_file(file_inspectors)
      if csv_empty?(xml_contents, "inspector") && !xml_contents.nil?
        puts "********** error al cargar CSV **********"
        return false
      else
        number_of_successfully_created_rows = 0
        CSV.parse(xml_contents, :headers => true) do |row|
          dependency = Dependency.find_by(name: row.to_hash['dependencia'], city_id: @city)
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
              puts '.'
              number_of_successfully_created_rows += 1
            else
              puts "********** DATO REPETIDO será omitido #{row_values} **********"
            end
          else
            puts "********** Una o más dependencias no coinciden, porfavor revisalos para continuar **********"
            return false
          end
        end
        puts "********** Número satisfactorio de registros creados para (#{file_inspectors.original_filename}): #{number_of_successfully_created_rows} **********"
        if number_of_successfully_created_rows > 0
          return true
        end
      return false
      end
    end



    def validate_requirements(file_requirements)
      puts '"********** REQUISITOS **********'
      xml_contents =  load_file(file_requirements)
      if csv_empty?(xml_contents, "requirement") && !xml_contents.nil?
        puts "********** error al cargar CSV **********"
        return false
      else
        number_of_successfully_created_rows = 0
        CSV.parse(xml_contents, :headers => true) do |row|
          city = City.find_by(name: row.to_hash['municipio'])
          name = row.to_hash['nombre']
          description = row.to_hash['descripcion']
          path = row.to_hash['path']

          row_values = { name: name, city: city, description: description, path: path }
          if city_validate?(city)
            if row_does_not_exist_in_the_db(Requirement, row_values)
              Requirement.create!(row_values)
              puts '.'
              number_of_successfully_created_rows += 1
            else
              puts "********** DATO REPETIDO será omitido #{row_values}  **********"
            end
          else
            puts "********** Municipio incorrecto NO TIENES PERMISO **********"
            return false
          end
        end
        puts "********** Número satisfactorio de registros creados para (#{file_requirements.original_filename}): #{number_of_successfully_created_rows} **********"
        if number_of_successfully_created_rows > 0
            return true
          end
        return false
      end
    end


    def validate_inspections(file_inspections)
      puts '"********** INSPECCIONES **********'
      xml_contents =  load_file(file_inspections)
      if csv_empty?(xml_contents, "inspection") && !xml_contents.nil?
        puts "********** error al cargar CSV **********"
        return false
      else
        number_of_successfully_created_rows = 0
        CSV.parse(xml_contents, :headers => true) do |row|
          dependency = Dependency.find_by(name: row.to_hash['dependencia'], city_id: @city)
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
                unless Line.where(name: giro).blank?
                  InspectionLine.create(inspection_id: inspection_created.id, line_id: Line.where(name: giro).first.id)
                  number_of_successfully_created_giros += 1
                else
                  puts "********** El giro: #{giro} no coincide con ninguno del dataset GIRO **********"
                end
              end
            else
              puts "********** DATO REPETIDO será omitido #{row_values} **********"
            end
          else
            puts "********** Una o más dependencias no coinciden, porfavor revisalos para continuar **********"
            return false
          end
          
          puts  "********** #{inspection_created.name} tiene Giros: #{number_of_successfully_created_giros} **********"
          
          number_of_successfully_created_requerimientos = 0
          requerimientos.split('; ').each do |requisito|
            unless Requirement.where(name: requisito).blank?
              InspectionRequirement.create(inspection_id: inspection_created.id, requirement_id: Requirement.where(name: requisito).first.id)
              number_of_successfully_created_requerimientos += 1
            else
              puts "********** El requisito: #{requisito} no coincide con ninguno del dataset Requisito **********"
            end
          end
          puts "********** #{inspection_created.name} tiene Requisitos: #{number_of_successfully_created_requerimientos} **********"
          number_of_successfully_created_rows  += 1
        end
        puts "********** Número satisfactorio de registros creados para (#{file_inspections.original_filename}): #{number_of_successfully_created_rows} **********"
        if number_of_successfully_created_rows > 0
          return true
        end
        return false
      end
    end


    def csv_empty?(file, name)
      if CSV.new(file, headers: :first_row).to_a.empty?
        puts "********** CSV esta vacio **********"
        return true
      else
        unless has_headers?(file,name)
          puts "********** CSV no tiene las cabeceras correctas **********"
          return  true
        else
          return false
        end
      end
      return false
    end

    def row_does_not_exist_in_the_db(model, search_values)
      !model.where(search_values).present?
    end

    def set_user
      @user ||= current_user
    end

    def city_validate?(city)
     city.present? && current_user.city_id == city.id
    end

    def set_city
      @city ||= City.find(current_user.city_id)
    end

    def load_file(file)
      xml_contents = nil
      if file.respond_to?(:read)
        xml_contents = file.read
      elsif file.respond_to?(:path)
        xml_contents = File.read(file.path)
      else
        puts "********** El archivo de dependencias está incorrecto: #{file.class.name}: #{file.inspect} **********"
      end
      return xml_contents
    end

    def delete_all_data
      inspector = Inspector.by_city(City.find(@city))
      unless inspector.blank?
        inspector.each do |inspector|
          inspector.delete
        end 
      end
      puts '********** Inspector borrados **********'


      inspection = Inspection.by_city(City.find(@city))
      unless inspection.blank?
        inspection.each do |inspection|
          inspection.delete
        end 
      end
      puts '********** Inspection borrados **********'


      Dependency.where(city_id: @city).delete_all
      puts '********** Dependencias borradas **********' 
      
      Line.where(city_id: @city).delete_all
      puts '********** Giros borrados **********' 

      Requirement.where(city_id: @city).delete_all
      puts '********** Requisitos borrados **********' 
 
    end


    def has_headers?(file, name)
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
        end  
      return false
    end


  end
end