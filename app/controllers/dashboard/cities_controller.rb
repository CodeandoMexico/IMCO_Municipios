module Dashboard
  class CitiesController < ApplicationController
    before_filter :set_city
    layout 'dashboard'

    def update
      file_dependency = params[:post][:dependency_file]
      file_lines = params[:post][:line_file]

      if validate_dependencies(file_dependency) && validate_lines(file_lines)

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




    def csv_empty?(file, name)
      if CSV.new(file, headers: :first_row).to_a.empty?
        puts "********** CSV esta vacio **********"
        return true
      else
        return !has_headers?(file,name)
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
      Dependency.where(city_id: @city).delete_all
      puts '********** Dependencia borrada **********' 
    end
    
    def  has_headers?(file, name)
      headers = CSV.parse(file)
      case name
        when 'Dependency'
          return headers[0].include?('nombre') && headers[0].include?('municipio')
        when 'line'
          return headers[0].include?('nombre') && headers[0].include?('municipio') && headers[0].include?('descripcion')
        end  
        puts "********** CSV no tiene las cabeceras correctas **********"
        return false
    end


  end
end
