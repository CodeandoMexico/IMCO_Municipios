#heroku run rake twitter:load_twitters
namespace :twitter do
 require 'csv'

desc "Load lines to the db"
  task :load_twitters  => :environment do |t, args|
    twitter_files = ['lib/datasets/twitts.csv']
    a = CatTwitter.all
    a.delete_all
    twitter_files.each_with_index do |twitter_file, index|
      number_of_successfully_created_rows = 0
      CSV.foreach(twitter_file, :headers => true) do |row|
        #llenamos
        state = row.to_hash['estado']
        town = row.to_hash['municipio']
        twitter = row.to_hash['twitter']
        #creamos
        CatTwitter.create( 
            state: state, 
            town: town, 
            twitter:  twitter)

          number_of_successfully_created_rows += 1
      end#termina scv each
      puts "Number of successfully created rows is (#{twitter_file}): #{number_of_successfully_created_rows}"
    end#tesmina each de files

  end #termina task

end#termina namespace