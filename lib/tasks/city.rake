#heroku run rake city:migrate

namespace :city do
  task :migrate => :environment do
    City.all.each_with_index do |city, index|
      if city.id == 1
        replace_blank_coordinates_for(city,19.2650275, -98.8996125)
      elsif city.id == 2
        replace_blank_coordinates_for(city,19.0245491, -99.4732384)
      elsif city.id == 3
        replace_blank_coordinates_for(city, 19.2931846, -99.521305)
      elsif city.id == 4
        replace_blank_coordinates_for(city,19.2621433, -99.5989734)
      elsif city.id == 5
        replace_blank_coordinates_for(city,19.0762474, -99.655818)
      elsif city.id == 6
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
