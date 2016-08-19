if Rails.env.production? || Rails.env.development?
  Sidekiq.configure_server do |config|
    config.redis = { size: 27 }
    
    database_url = ENV['DATABASE_URL']
    if database_url
      ENV['DATABASE_URL'] = "#{database_url}?pool=20"
      ActiveRecord::Base.establish_connection
    end
  end

  Sidekiq.configure_client do |config|
    config.redis = { size: 27 }
  end
end