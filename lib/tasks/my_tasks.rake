namespace :my_tasks do
 require 'csv'   

  desc "Importa CSV formation steps a la BD"
  task :import_formation_steps => :environment do   
    file = '/Users/mikesaurio/Desktop/csv/apertura.csv'
    CSV.foreach(file, :headers => true) do |row|
      FormationStep.create!(row.to_hash)
    end
  end
end
