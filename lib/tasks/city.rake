#heroku run rake city:migrate

namespace :city do
  task :migrate => :environment do
    City.all.each_with_index do |city, index|
      if index == 0
        replace_blank_coordinates_for(city,19.2650275, -98.8996125)
      elsif index == 1
        replace_blank_coordinates_for(city,19.0245491, -99.4732384)
      elsif index == 2
        replace_blank_coordinates_for(city, 19.2931846, -99.521305)
      elsif index == 3
        replace_blank_coordinates_for(city,19.2621433, -99.5989734)
      elsif index == 4
        replace_blank_coordinates_for(city,19.0762474, -99.655818)
      elsif index == 5
        replace_blank_coordinates_for(city,19.284311, -99.6555047)
      end
    end
    puts "\nDone."
  end
end

def replace_blank_coordinates_for(city, latitude, longitude)
  city.latitude = latitude
  city.longitude = longitude
  if city.save
    print '.'
  else
    print 'f'
  end
end
