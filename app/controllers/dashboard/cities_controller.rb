module Dashboard
  class CitiesController < ApplicationController
    before_filter :set_city
    layout 'dashboard'

    def update
      file_dependency = params[:post][:dependency_file]
      file_lines = params[:post][:line_file]
      file_inspectors = params[:post][:inspector_file]

      delete_all_data
      
      if validate_dependencies(file_dependency) && validate_lines(file_lines) && validate_inspectors(file_inspectors)

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
      else
        number_of_successfully_created_rows = 0
          CSV.parse(xml_contents, :headers => true) do |row|
            city = City.find_by(name: row.to_hash['municipio'])
            name = row.to_hash['nombre']
            if city_validate?(city)
              if row_does_not_exist_in_the_db(Dependency, { name: name, city: city })
                Dependency.create(name: name, city: city)
                puts '.'
                number_of_successfully_created_rows += 1
              else
                puts "********** DATO REPETIDO será omitido #{name} | City #{city} **********"
              end
            else
              puts "********** Municipio incorrecto NO TIENES PERMISO **********"
              return false
            end
          end
          puts "Número satisfactorio de registros creados para (#{file_dependency.original_filename}): #{number_of_successfully_created_rows}"
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
      else
        number_of_successfully_created_rows = 0
        CSV.parse(xml_contents, :headers => true) do |row|
          city = City.find_by(name: row.to_hash['municipio'])
          name = row.to_hash['nombre']
          description = row.to_hash['descripcion']
          if city_validate?(city)
            if row_does_not_exist_in_the_db(Line, { name: name, city: city })
              Line.create(name: name, description: description , city: city)
              puts '.'
              number_of_successfully_created_rows += 1
            else
              puts "********** DATO REPETIDO será omitido #{name} | City #{city} **********"
            end
          else
            puts "********** Municipio incorrecto NO TIENES PERMISO **********"
            return false
          end
        end
        puts "Número satisfactorio de registros creados para (#{file_lines.original_filename}): #{number_of_successfully_created_rows}"
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
            if  row_does_not_exist_in_the_db(Inspector, {name: name, dependency: dependency, matter: subject})
              Inspector.create(dependency: dependency, name: name, validity: valid_through, matter: subject, supervisor: supervisor, photo: photo, contact: contact )
              puts '.'
              number_of_successfully_created_rows += 1
            else
              puts "********** DATO REPETIDO será omitido #{name} | City #{city} **********"
            end
          else
            puts "********** Una o más dependencias no coinciden, porfavor revisalos para continuar **********"
            return false
          end
        end
        puts "Número satisfactorio de registros creados para (#{file_inspectors.original_filename}): #{number_of_successfully_created_rows}"
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
        inspector.delete_all
      end
      puts '********** Inspector borrados **********'
      Dependency.where(city_id: @city).delete_all
      puts '********** Dependencias borradas **********' 
      Line.where(city_id: @city).delete_all
      puts '********** Giros borrados **********' 
 
    end

    def has_headers?(file, name)
      headers = CSV.parse(file)
      case name
        when 'Dependency'
          puts '********** validando cabeceras dependencia **********'
          return headers[0].include?('nombre') && headers[0].include?('municipio')
        when 'line'
          '********** validando cabeceras dependencia **********'
          return headers[0].include?('nombre') && headers[0].include?('municipio') && headers[0].include?('descripcion')
        when 'inspector'
          '********** validando cabeceras dependencia **********'
          return headers[0].include?('dependencia') && headers[0].include?('nombre') && headers[0].include?('vigencia') && headers[0].include?('materia') && headers[0].include?('supervisor') && headers[0].include?('contacto') && headers[0].include?('foto')
        end  
        return false
    end


  end
end
