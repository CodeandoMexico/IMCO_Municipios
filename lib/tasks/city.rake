namespace :city do
  task :migrate => :environment do
    City.all.each do |city|
      # dummy latitude and longitude will be set to San Luis P.
      replace_blank_coordinates_for(city)
    end
    puts "\nDone."
  end
end

def replace_blank_coordinates_for(city, latitude=22.1498200, longitude=-100.9791600)
  city.latitude = latitude
  city.longitude = longitude
  if city.save
    print '.'
  else
    print 'f'
  end
end
