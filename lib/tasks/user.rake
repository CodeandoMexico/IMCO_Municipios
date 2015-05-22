namespace :user do
  task :migrate => :environment do
    User.where(admin:false).each_with_index do |user, idx|
      replace_blanks_with_dummy_data_for(user, {
        name: 'Full Name',
        email: "placeholder+#{idx}@email.com",
        business_name: 'Business Name',
        address: 'Change this address',
        operation_license: 'A00000',
        city_id: 3,
        latitude: '19.4284700',
        longitude: '-99.1276600'
      })
    end
    puts "\nDone."
  end
end

def replace_blanks_with_dummy_data_for(model, fields)
  fields.each do |key, value|
    model[key] = value if model[key].blank?
  end
  if model.save
    print '.'
  else
    print 'f'
  end
end
