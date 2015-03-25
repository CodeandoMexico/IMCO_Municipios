## In this order the tasks should be run
# rake my_tasks:load_lines
# rake my_tasks:load_dependencies
# rake my_tasks:load_inspectors
# rake my_tasks:load_requirements
# rake my_tasks:load_inspections
# rake my_tasks:load_formation_steps
# rake my_tasks:load_procedures

namespace :my_tasks do
 require 'csv'

  desc "Load lines to the db"
  task :load_lines  => :environment do |t, args| 

     cities_files = ['lib/datasets/giros_chalco.csv', 'lib/datasets/giros_metepec.csv', 'lib/datasets/giros_lerma.csv']

    clean_db(UserFormationStep)#al perder las referencias se debe eliminar las relaciones
    clean_db(Line) 
    clean_db(Dependency)# let's erase everyone from the db
    clean_db(Inspector)
    clean_db(Requirement)
    clean_db(Inspection)
    clean_db(FormationStep)
    clean_db(Procedure)
    clean_db(ProcedureLine)
    clean_db(ProcedureRequirement)
    clean_db(InspectionLine) 
    clean_db(InspectionRequirement) 
    
    cities_files.each do |city_file|
      CSV.foreach(city_file, :headers => true) do |row|
        city = Municipio.find_by(nombre: row.to_hash['municipio_id'])
        name = row.to_hash['nombre']
        description = row.to_hash['descripcion']

        if city.present? && row_does_not_exist_in_the_db(Line, { nombre: name, municipio: city })
          Line.create(nombre: name, descripcion: description , municipio: city)
        end

      end
    end
  end

  desc "Load dependencies to the db"
  task :load_dependencies  => :environment do |t, args|

    #clean_db(Dependency) # let's erase everyone from the db

    cities_files = ['lib/datasets/dependencias_chalco.csv', 'lib/datasets/dependencias_metepec.csv','lib/datasets/dependencias_lerma.csv']

    cities_files.each do |city_file|
      CSV.foreach(city_file, :headers => true) do |row|
        city = Municipio.find_by(nombre: row.to_hash['municipio_id'])
        name = row.to_hash['nombre']

        if city.present? && row_does_not_exist_in_the_db(Dependency, { nombre: name, municipio: city })
          Dependency.create(nombre: name, municipio: city)
        end
      end
    end
  end

  desc "Load inspectors to the db"
  
  task :load_inspectors  => :environment do |t, args|

    cities_files = ['lib/datasets/inspectores_chalco.csv', 'lib/datasets/inspectores_metepec.csv','lib/datasets/inspectores_lerma.csv']

   # clean_db(Inspector) # let's erase everyone from the db
    cities_files.each_with_index do |city_file, index|
      # init variables
      number_of_successfully_created_rows = 0
      CSV.foreach(city_file, :headers => true) do |row|

        if index == 0
          dependency = Dependency.find_by(nombre: row.to_hash['dependencia_id'], municipio_id: '1')
        elsif index == 1
          dependency = Dependency.find_by(nombre: row.to_hash['dependencia_id'], municipio_id: '4')
        elsif index == 2
          dependency = Dependency.find_by(nombre: row.to_hash['dependencia_id'], municipio_id: '3')
        end

        name = row.to_hash['nombre']
        valid_through = row.to_hash['vigencia']
        subject = row.to_hash['materia']
        supervisor = row.to_hash['supervisor']
        contact = row.to_hash['contacto']
        photo = row.to_hash['foto']
    
        if  row_does_not_exist_in_the_db(Inspector, {
            nombre: name,
            dependency: dependency,
            materia: subject
          })
          Inspector.create!(
             dependency: dependency,
             nombre: name,
             vigencia: valid_through,
             materia: subject,
             supervisor: supervisor,
            foto: photo,
             contacto: contact
          )

          number_of_successfully_created_rows = number_of_successfully_created_rows + 1
        else
            puts "#{name} | #{valid_through} | #{subject} | #{supervisor} | #{contact} | #{photo} | #{}"
        end

      end
      puts "Number of successfully created rows is (#{city_file}): #{number_of_successfully_created_rows}"
    end
  end

  desc "Load requirements to the db"
  task :load_requirements  => :environment do |t, args|

    #clean_db(Requirement) # let's erase everyone from the db

    cities_files = ['lib/datasets/requisitos_chalco.csv', 'lib/datasets/requisitos_metepec.csv','lib/datasets/requisitos_lerma.csv']

    cities_files.each do |city_file|
      # init variables
      number_of_successfully_created_rows = 0
      CSV.foreach(city_file, :headers => true) do |row|
        city = Municipio.find_by(nombre: row.to_hash['municipio_id'])
        name = row.to_hash['nombre']
        description = row.to_hash['descripcion']
        path = row.to_hash['path']

        row_values = { nombre: name, municipio: city, descripcion: description, path: path }
        if city.present? && row_does_not_exist_in_the_db(Requirement, row_values)
          Requirement.create!(row_values)
          number_of_successfully_created_rows = number_of_successfully_created_rows + 1
        else
          puts "DATO REPETIDO #{row_values.inspect}"
        end
      end
      puts "Number of successfully created rows is (#{city_file}): #{number_of_successfully_created_rows}"
    end
  end

  desc "Load inspections to the db"
  task :load_inspections  => :environment do |t, args|

    cities_files = ['lib/datasets/inspecciones_chalco.csv', 'lib/datasets/inspecciones_metepec.csv','lib/datasets/inspecciones_lerma.csv']
    #clean_db(Inspection) # let's erase everyone from the db
    cities_files.each_with_index do |city_file, index|
      # init variables
      number_of_successfully_created_rows = 0
      CSV.foreach(city_file, :headers => true) do |row|
        if index == 0
          dependency = Dependency.find_by(nombre: row.to_hash['dependency_name'], municipio_id: '1')
        elsif index == 1
          dependency = Dependency.find_by(nombre: row.to_hash['dependency_name'], municipio_id: '4')
        elsif index == 2
          dependency = Dependency.find_by(nombre: row.to_hash['dependency_name'], municipio_id: '3')
        end

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
          nombre: name,
          materia: subject,
          duracion: period,
          norma: norm,
          antes: before_tips,
          durante: during_tips,
          despues: after_tips,
          sancion: sanctions,
          certification: certification
        }

        if dependency.present? && row_does_not_exist_in_the_db(Inspection, row_values)
         a =  Inspection.create(row_values)


         giros.split('; ').each do |v|
             unless Line.where(nombre: v).first.nil?
                 InspectionLine.create(inspection_id: a.id, line_id: Line.where(nombre: v).first.id)
             end
           end

          requerimientos.split('; ').each do |v|
              unless Requirement.where(nombre: v).first.nil?
                InspectionRequirement.create(inspection_id: a.id, requirement_id: Requirement.where(nombre: v).first.id)
              end
           end

          number_of_successfully_created_rows = number_of_successfully_created_rows + 1
        else
            # puts "#{ row_values[:nombre]} | #{row_values[:materia]} | #{row_values[:duracion]}"
            puts "#{ row_values.inspect }"
        end

      end
      puts "Number of successfully created rows is (#{city_file}): #{number_of_successfully_created_rows}"
    end
  end


  desc "Load formation stsp to the db"
  task :load_formation_steps  => :environment do |t, args|

  #  clean_db(FormationStep) # let's erase everyone from the db

    cities_files = ['lib/datasets/apertura_chalco.csv', 'lib/datasets/apertura_metepec.csv','lib/datasets/apertura_lerma.csv']

    cities_files.each do |city_file|
      # init variables
      number_of_successfully_created_rows = 0
      CSV.foreach(city_file, :headers => true) do |row|
        city = Municipio.find_by(nombre: row.to_hash['municipio_id'])
        name = row.to_hash['nombre']
        description = row.to_hash['descripcion']
        path = row.to_hash['path']
        type = getTipoApertura(row.to_hash['tipo'])

        row_values = { name: name, municipio: city, description: description, path: path, type: type }
        if city.present? && row_does_not_exist_in_the_db(FormationStep, row_values)
          FormationStep.create!(row_values)
          number_of_successfully_created_rows = number_of_successfully_created_rows + 1
        else
          puts "#{row_values.inspect}"
        end
      end
      puts "Number of successfully created rows is (#{city_file}): #{number_of_successfully_created_rows}"
    end
  end


   desc "Load procedures to the db"
  task :load_procedures  => :environment do |t, args|

    cities_files = ['lib/datasets/tramites_chalco.csv', 'lib/datasets/tramites_metepec.csv','lib/datasets/tramites_lerma.csv']

    #clean_db(Procedure) # let's erase everyone from the db
    #clean_db(ProcedureLine)
   # clean_db(ProcedureRequirement)

    cities_files.each_with_index do |city_file, index|
      # init variables
      number_of_successfully_created_rows = 0
      CSV.foreach(city_file, :headers => true) do |row|


         if index == 0
          dependency = Dependency.find_by(nombre: row.to_hash['dependency_name'], municipio_id: '1')
        elsif index == 1
          dependency = Dependency.find_by(nombre: row.to_hash['dependency_name'], municipio_id: '4')
        elsif index == 2
          dependency = Dependency.find_by(nombre: row.to_hash['dependency_name'], municipio_id: '3')
        end
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
            nombre: name,
            dependency: dependency,
            tipo: getTipo(tipo)
          })
         a =  Procedure.create(
             dependency: dependency,
             nombre: name,
             duracion: time,
             costo: cost,
             vigencia: supervisor,
             contacto: contact,
             tipo: getTipo(tipo),
             categoria: categoria,
             sare: sare
          )

          giros.split('; ').each do |v|
             unless Line.where(nombre: v).first.nil?
                 ProcedureLine.create(procedure_id: a.id, line_id: Line.where(nombre: v).first.id)
             end
           end

          tramites.split('; ').each do |v|
              unless Requirement.where(nombre: v).first.nil?
                ProcedureRequirement.create(procedure_id: a.id, requirement_id: Requirement.where(nombre: v).first.id)
              end
           end

          number_of_successfully_created_rows = number_of_successfully_created_rows + 1
        else
            puts "#{name} | #{time} | #{cost} | #{dependency.nombre} | #{contact} | #{supervisor} | #{}"
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


end
