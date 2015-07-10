#heroku run rake business:load_business
namespace :business do
 require 'csv'

desc "Load lines to the db"
  task :load_business  => :environment do |t, args|
    cities_files = ['lib/datasets/Licencias/LicenciasChalco.csv','lib/datasets/Licencias/LicenciasMetepec.csv']
    cities_files.each_with_index do |city_file, index|
      number_of_successfully_created_rows = 0
      CSV.foreach(city_file, :headers => true) do |row|
        #llenamos
        nombre_empresa = row.to_hash['nombre']
        horario = row.to_hash['horario']
        direccion = row.to_hash['direccion']
        latitud = row.to_hash['latitud']
        longitud = row.to_hash['longitud']
        ciudad = City.find_by(name: row.to_hash['ciudad'])
        buscar_giro = Line.where(name: row.to_hash['giro'])
        if buscar_giro.empty?
          giro = Line.where(city_id: ciudad).first.id
        else
          giro = buscar_giro.last.id
        end
        #creamos
        User.create(name: "Empresario#{index}#{number_of_successfully_created_rows}", 
          email: "sincorreo#{index}#{number_of_successfully_created_rows}@email.com",
           password: "codeandoimco#{index}#{number_of_successfully_created_rows}",
            city_id: ciudad.id, 
            admin: false, 
            business_name:  nombre_empresa,
            address: direccion,
            operation_license: "00000000000000000",
            schedule: horario,
            line_id:  giro,
            latitude: latitud,
            longitude: longitud)

          number_of_successfully_created_rows += 1
      end#termina scv each
      puts "Number of successfully created rows is (#{city_file}): #{number_of_successfully_created_rows}"
    end#tesmina each de files

  end #termina task

end#termina namespace