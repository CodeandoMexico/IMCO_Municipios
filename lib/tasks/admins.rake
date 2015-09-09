#heroku run rake admins:create
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
end