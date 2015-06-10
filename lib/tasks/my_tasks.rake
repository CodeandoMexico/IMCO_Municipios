## In this order the tasks should be run
#rake my_tasks:reseed
#heroku run rake my_tasks:delete_all_datasets
#heroku run rake my_tasks:load_all_data
# heroku run rake my_tasks:load_lines
# heroku run rake my_tasks:load_dependencies
# heroku run rake my_tasks:load_inspectors
# heroku run rake my_tasks:load_requirements
# heroku run rake my_tasks:load_inspections
# heroku run rake my_tasks:load_formation_steps
# heroku run rake my_tasks:load_procedures

namespace :my_tasks do
 require 'csv'

 desc 'Drop, create, migrate then seed the development database'
 task reseed: [
   'db:reset'
 ]


 desc "beginning datasets"
 task :beginning_datasets => :environment do |t,env|
    #creando ciudades
    if  City.where(name: 'Chalco').empty?
      a = City.create(name: 'Chalco', contact_email: 'chalco@gmail.com')
      user_admin= User.create(email: 'mikesaurio@codeandomexico.org', password: 'codeandochalco', city_id: a.id, admin: true)
    end

    if  City.where(name: 'Huixquilucan').empty?
      a = City.create(name: 'Huixquilucan', contact_email: 'huixquilucan@gmail.com')
     User.create(email: 'raul@codeandomexico.org', password: 'codeandohuixquilucan', city_id: a.id, admin: true)
    end

    if  City.where(name: 'Lerma').empty?
      a = City.create(name: 'Lerma', contact_email: 'lerma@gmail.com')
       User.create(email: 'juanpablo@codeandomexico.org', password: 'codeandolerma', city_id: a.id, admin: true)
    end

    if  City.where(name: 'Metepec').empty?
      a = City.create(name: 'Metepec', contact_email: 'metepec@gmail.com')
     User.create(email: 'oscar@codeandomexico.com', password: 'codeandometepec', city_id: a.id, admin: true)
    end

    if  City.where(name: 'Tenango del Valle').empty?
      a = City.create(name: 'Tenango del Valle', contact_email: 'tenangodelvalle@gmail.com')
     User.create(email: 'paulina@codeandomexico.com', password: 'codeandotenango', city_id: a.id, admin: true)
    end

    if  City.where(name: 'Toluca').empty?
      a = City.create(name: 'Toluca', contact_email: 'toluca@gmail.com')
     User.create(email: 'ricardo@codeandomexico.org', password: 'codeandotoluca', city_id: a.id, admin: true)
    end
  end


  desc "Load lines to the db"
  task :load_lines  => :environment do |t, args|
    cities_files = ['lib/datasets/Chalco/giros_chalco.csv','lib/datasets/Huixquilucan/giros_huixquilucan.csv','lib/datasets/Lerma/giros_lerma.csv','lib/datasets/Metepec/giros_metepec.csv','lib/datasets/TenangoDelValle/giros_tenango_del_valle.csv','lib/datasets/Toluca/giros_toluca.csv']
    cities_files.each do |city_file|
      number_of_successfully_created_rows = 0
      CSV.foreach(city_file, :headers => true) do |row|
        city = City.find_by(name: row.to_hash['municipio_id'])
        name = row.to_hash['nombre']
        description = row.to_hash['descripcion']
        if city.present? && row_does_not_exist_in_the_db(Line, { name: name, city: city })
          Line.create(name: name, description: description , city: city)
          number_of_successfully_created_rows += 1
        else
          puts "DATO REPETIDO #{name} | City #{city.name}"
        end
      end
      puts "Number of successfully created rows is (#{city_file}): #{number_of_successfully_created_rows}"
    end
  end

  desc "Load dependencies to the db"
  task :load_dependencies  => :environment do |t, args|
    cities_files = ['lib/datasets/Chalco/dependencias_chalco.csv','lib/datasets/Huixquilucan/dependencias_huixquilucan.csv','lib/datasets/Lerma/dependencias_lerma.csv','lib/datasets/Metepec/dependencias_metepec.csv','lib/datasets/TenangoDelValle/dependencias_tenango_del_valle.csv','lib/datasets/Toluca/dependencias_toluca.csv']
    cities_files.each do |city_file|
      number_of_successfully_created_rows = 0
      CSV.foreach(city_file, :headers => true) do |row|
        city = City.find_by(name: row.to_hash['municipio_id'])
        name = row.to_hash['nombre']
        if city.present? && row_does_not_exist_in_the_db(Dependency, { name: name, city: city })
          Dependency.create(name: name, city: city)
          number_of_successfully_created_rows += 1
        else
          puts "DATO REPETIDO #{name} | City #{city}"
        end
      end
      puts "Number of successfully created rows is (#{city_file}): #{number_of_successfully_created_rows}"
    end
  end

  desc "Load inspectors to the db"
  task :load_inspectors  => :environment do |t, args|
    cities_files = ['lib/datasets/Chalco/inspectores_chalco.csv','lib/datasets/Huixquilucan/inspectores_huixquilucan.csv','lib/datasets/Lerma/inspectores_lerma.csv','lib/datasets/Metepec/inspectores_metepec.csv','lib/datasets/TenangoDelValle/inspectores_tenango_del_valle.csv','lib/datasets/Toluca/inspectores_toluca.csv']
    cities_files.each_with_index do |city_file, index|
      number_of_successfully_created_rows = 0
      CSV.foreach(city_file, :headers => true) do |row|
        dependency = Dependency.find_by(name: row.to_hash['dependencia_id'], city_id: index+1)
        name = row.to_hash['nombre']
        valid_through = row.to_hash['vigencia']
        subject = row.to_hash['materia']
        supervisor = row.to_hash['supervisor']
        contact = row.to_hash['contacto']
        photo = row.to_hash['foto']

        if  row_does_not_exist_in_the_db(Inspector, {
          name: name,
          dependency: dependency,
          matter: subject
          })
        Inspector.create!(
          dependency: dependency,
          name: name,
          validity: valid_through,
          matter: subject,
          supervisor: supervisor,
          photo: photo,
          contact: contact
          )
        number_of_successfully_created_rows += 1
      else
        puts "#{name} | #{valid_through} | #{subject} | #{supervisor} | #{contact} | #{photo} | #{}"
      end
    end
    puts "Number of successfully created rows is (#{city_file}): #{number_of_successfully_created_rows}"
  end
end

desc "Load requirements to the db"
task :load_requirements  => :environment do |t, args|
  cities_files = ['lib/datasets/Chalco/requisitos_chalco.csv','lib/datasets/Huixquilucan/requisitos_huixquilucan.csv','lib/datasets/Lerma/requisitos_lerma.csv','lib/datasets/Metepec/requisitos_metepec.csv','lib/datasets/TenangoDelValle/requisitos_tenango_del_valle.csv','lib/datasets/Toluca/requisitos_toluca.csv']
  cities_files.each do |city_file|
    number_of_successfully_created_rows = 0
    CSV.foreach(city_file, :headers => true) do |row|
      city = City.find_by(name: row.to_hash['municipio_id'])
      name = row.to_hash['nombre']
      description = row.to_hash['descripcion']
      path = row.to_hash['path']
      row_values = { name: name, city: city, description: description, path: path }
      if city.present? && row_does_not_exist_in_the_db(Requirement, row_values)
        Requirement.create!(row_values)
        number_of_successfully_created_rows += 1
      else
        puts "DATO REPETIDO #{row_values.inspect}"
      end
    end
    puts "Number of successfully created rows is (#{city_file}): #{number_of_successfully_created_rows}"
  end
end

desc "Load inspections to the db"
task :load_inspections  => :environment do |t, args|
  cities_files = ['lib/datasets/Chalco/inspecciones_chalco.csv','lib/datasets/Huixquilucan/inspecciones_huixquilucan.csv','lib/datasets/Lerma/inspecciones_lerma.csv','lib/datasets/Metepec/inspecciones_metepec.csv','lib/datasets/TenangoDelValle/inspecciones_tenango_del_valle.csv','lib/datasets/Toluca/inspecciones_toluca.csv']
  cities_files.each_with_index do |city_file, index|
    number_of_successfully_created_rows = 0
    CSV.foreach(city_file, :headers => true) do |row|
      dependency = Dependency.find_by(name: row.to_hash['dependency_name'], city_id: index+1)
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

      row_values = {
        dependency: dependency,
        name: name,
        matter: subject,
        duration: period,
        rule: norm,
        before: before_tips,
        during: during_tips,
        after: after_tips,
        sanction: sanctions,
        certification: certification
      }

      if dependency.present? && row_does_not_exist_in_the_db(Inspection, row_values)
        inspection_created =  Inspection.create(row_values)

        number_of_successfully_created_giros = 0
        giros.split('; ').each do |v|
          unless Line.where(name: v).first.nil?
            InspectionLine.create(inspection_id: inspection_created.id, line_id: Line.where(name: v).first.id)
            number_of_successfully_created_giros += 1
          end
        end
        puts  "#{inspection_created.name} tiene Giros: #{number_of_successfully_created_giros}"

        number_of_successfully_created_requerimientos = 0
        requerimientos.split('; ').each do |v|
          unless Requirement.where(name: v).first.nil?
            InspectionRequirement.create(inspection_id: inspection_created.id, requirement_id: Requirement.where(name: v).first.id)
            number_of_successfully_created_requerimientos += 1
          end
        end
        puts "#{inspection_created.name} tiene Requisitos: #{number_of_successfully_created_requerimientos}"

        number_of_successfully_created_rows  += 1
      else
        puts "#{ name} | #{city_file}"
      end

    end
    puts "Number of successfully created rows is (#{city_file}): #{number_of_successfully_created_rows}"
  end
end


desc "Load formation stsp to the db"
task :load_formation_steps  => :environment do |t, args|
  cities_files = ['lib/datasets/Chalco/apertura_chalco.csv','lib/datasets/Huixquilucan/apertura_huixquilucan.csv','lib/datasets/Lerma/apertura_lerma.csv','lib/datasets/Metepec/apertura_metepec.csv','lib/datasets/TenangoDelValle/apertura_tenango_del_valle.csv','lib/datasets/Toluca/apertura_toluca.csv']
  cities_files.each do |city_file|
    number_of_successfully_created_rows = 0
    CSV.foreach(city_file, :headers => true) do |row|
      city = City.find_by(name: row.to_hash['municipio_id'])
      name = row.to_hash['nombre']
      description = row.to_hash['descripcion']
      path = row.to_hash['path']
      type = getTipoApertura(row.to_hash['tipo'])
      type_of_procedure = row.to_hash['tramite']
      row_values = { name: name, city: city, description: description, path: path, type_formation_step: type, type_of_procedure:  type_of_procedure}
      if city.present? && row_does_not_exist_in_the_db(FormationStep, row_values)
        FormationStep.create!(row_values)
        number_of_successfully_created_rows += 1
      else
        puts "#{row_values.inspect}"
      end
    end
    puts "Number of successfully created rows is (#{city_file}): #{number_of_successfully_created_rows}"
  end
end


desc "Load procedures to the db"
task :load_procedures  => :environment do |t, args|
  cities_files = ['lib/datasets/Chalco/tramites_chalco.csv','lib/datasets/Huixquilucan/tramites_huixquilucan.csv','lib/datasets/Lerma/tramites_lerma.csv','lib/datasets/Metepec/tramites_metepec.csv','lib/datasets/TenangoDelValle/tramites_tenango_del_valle.csv','lib/datasets/Toluca/tramites_toluca.csv']
  cities_files.each_with_index do |city_file, index|
    number_of_successfully_created_rows = 0
    CSV.foreach(city_file, :headers => true) do |row|
      dependency = Dependency.find_by(name: row.to_hash['dependency_name'], city_id: index+1)
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

      if dependency.present? && row_does_not_exist_in_the_db(Procedure, {
        name: name,
        dependency: dependency,
        type_procedure: getTipo(tipo)
        })
      a =  Procedure.create(
        dependency: dependency,
        name: name,
        long: time,
        cost: cost,
        validity: supervisor,
        contact: contact,
        type_procedure: getTipo(tipo),
        category: categoria,
        sare: sare
        )

      number_of_successfully_created_giros = 0
      giros.split('; ').each do |v|
        unless Line.where(name: v).first.nil?
          ProcedureLine.create(procedure_id: a.id, line_id: Line.where(name: v).first.id)
          number_of_successfully_created_giros += 1
        end
      end
      puts  "#{a.name} tiene Giros: #{number_of_successfully_created_giros}"

      number_of_successfully_created_requerimientos = 0
      tramites.split('; ').each do |v|
        unless Requirement.where(name: v).first.nil?
          ProcedureRequirement.create(procedure_id: a.id, requirement_id: Requirement.where(name: v).first.id)
          number_of_successfully_created_requerimientos += 1
        end
      end
      puts "#{a.name} tiene Requisitos: #{number_of_successfully_created_requerimientos}"

      number_of_successfully_created_rows +=  1
    else
      puts "#{name}"
    end

  end
  puts "Number of successfully created rows is (#{city_file}): #{number_of_successfully_created_rows}"
end
end

def getTipo(tipo)
  if tipo == 'Física'
    'TF'
  elsif tipo == 'Moral'
    'TM'
  else
    'A'
  end
end

def getTipoApertura(tipo)
  if tipo == 'Física'
    'AF'
  elsif tipo == 'Moral'
    'AM'
  else
    'A'
  end
end


def row_does_not_exist_in_the_db(model, search_values)
  !model.where(search_values).present?
end

def clean_db(model)
  model.delete_all
end

desc "Load all data to the db"
task load_all_data: [:reseed, :beginning_datasets, :load_lines, :load_dependencies, :load_inspectors, :load_requirements, :load_inspections, :load_formation_steps, :load_procedures]


end
