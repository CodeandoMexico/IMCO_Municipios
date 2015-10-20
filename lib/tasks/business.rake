#heroku run rake business:load_business
namespace :business do
 require 'csv'

desc "Load lines to the db"
  task :load_business  => :environment do |t, args|
    cities_files = ['lib/datasets/Licencias/LicenciasChalco.csv','lib/datasets/Licencias/LicenciasMetepec.csv']
   # a = User.where(city_id: 1, admin: false)
   # a.delete_all
   #Line.where(name: Otro, description: "Sin giro conocido" , city: a.id).delete_all
   # a = User.where(city_id: 4, admin: false)
   # a.delete_all
   #Line.where(name: Otro, description: "Sin giro conocido" , city: a.id).delete_all
    
    cities_files.each_with_index do |city_file, index|
      if index == 0
          a =  City.where(name: 'Chalco').last
          Line.create(name: "Otro", description: "Sin giro conocido" , city: a)
          user = User.create(email: 'usuariochalco@gmail.com', password: 'codeandoimco', city_id: a.id, admin: false)
      else 
        a =  City.where(name: 'Metepec').last
        Line.create(name: "Otro", description: "Sin giro conocido" , city: a)
        user = User.create(email: 'usuariometepec@gmail.com', password: 'codeandoimco', city_id: a.id, admin: false)
      end
      number_of_successfully_created_rows = 0
      CSV.foreach(city_file, :headers => true) do |row|
        nombre_empresa = row.to_hash['nombre']
        horario = row.to_hash['horario']
        direccion = row.to_hash['direccion']
        latitud = row.to_hash['latitud']
        longitud = row.to_hash['longitud']
        ciudad = City.find_by(name: row.to_hash['ciudad'])
        buscar_giro = Line.where(name: row.to_hash['giro'])
        if buscar_giro.blank?
          giro = Line.where(name: "Otro").first.id
        else
          giro = buscar_giro.last.id
        end
        #creamos
        Business.create( 
            city_id: ciudad.id, 
            user_id: user.id,
            name:  nombre_empresa,
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