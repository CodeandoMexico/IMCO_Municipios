module Dashboard
  class CitiesController < ApplicationController
    before_filter :set_city
    layout 'dashboard'

    def update
      file_dependency = params[:post][:dependency_file]
      if validate_dependency(file_dependency)

      else
        delete_all_data
      end
    end

    private
    def csv_empty?(file, name)
      if CSV.new(file, headers: :first_row).to_a.empty?
        puts "CSV is empty"
        return true
      else
        return !has_headers?(file,name)
      end
      return false
    end

    def validate_dependency(file_dependency)
        if file_dependency.respond_to?(:read)
          xml_contents = file_dependency.read
        elsif file_dependency.respond_to?(:path)
          xml_contents = File.read(file_dependency.path)
        else
          puts "********** El archivo de dependencias está incorrecto: #{file_dependency.class.name}: #{file_dependency.inspect} **********"
          return false
        end

      if csv_empty?(xml_contents, "Dependency")
        puts "********** El CSV #{file_dependency.original_filename} tiene un formato erroneo**********"
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

    def delete_all_data
      Dependency.where(city_id: @city).delete_all
      puts '********** Dependencia borrada **********' 
    end
    
    def  has_headers?(file, name)
        headers = CSV.parse(file)
        case name
        when 'Dependency'
          return headers[0].include?('nombre') && headers[0].include?('municipio')
        end
        puts "CSV no tiene las cabeceras correctas"
        return false
    end


  end
end
