#heroku run rake admins:create
#heroku run rake admins:cities
#heroku run rake admins:new_city
namespace :admins do

 desc "beginning admins"
 task :create => :environment do |t,env|
    #creando adminitradores cambiar al momento de subir
    User.where(admin: true).delete_all
    a =  City.where(name: 'Chalco').last
     User.create(email: 'carlos.grandet@imco.org.mx', password: 'codeandoimco', city_id: a.id, admin: true)
    puts "."
    a =  City.where(name: 'Huixquilucan').last
     User.create(email: 'mariana.tapia@imco.org.mx', password: 'codeandoimco', city_id: a.id, admin: true)
    puts "."
    a =   City.where(name: 'Lerma').last
       User.create(email: 'cesar.resendiz@imco.org.mx', password: 'codeandoimco', city_id: a.id, admin: true)
    puts "."
    a =  City.where(name: 'Metepec').last
     User.create(email: 'mikesaurio@codeandomexico.org', password: 'codeandoimco', city_id: a.id, admin: true)
    puts "."
     a =  City.where(name: 'Toluca').last
     User.create(email: 'juanpablo@codeandomexico.org', password: 'codeandoimco', city_id: a.id, admin: true)
    puts "."
     a =  City.where(name: 'Tenango del Valle').last
     User.create(email: 'raul@codeandomexico.org', password: 'codeandoimco', city_id: a.id, admin: true)

  end

desc "beginning cities"
 task :cities => :environment do |t,env|
    #creando adminitradores cambiar al momento de subir
    City.all.each do |city|
        city.activated = true
        if city.save
            puts '.'
        else
            puts 'F'
        end
    end    
  end


desc "create city and first admin"
 task :new_city => :environment do |t,env|
    a = City.create(name: 'Municipio El Saurio')
    puts '*** Municipio creado ***'
    User.create(email: 'mike@gmail.com', password: 'codeandoimco', city_id: a.id, admin: true)
    puts '*** Usuario creado ***'
  end

end