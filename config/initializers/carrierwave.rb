CarrierWave.configure do |config|
  if Rails.env.development? || Rails.env.test?
    config.storage = :file
  else
    config.storage = :fog
    config.fog_credentials = {
      :provider               => 'AWS',                        # required
      :aws_access_key_id      => ENV['AMAZON_ACCESS_KEY'],                        # required
      :aws_secret_access_key  => ENV['AMAZON_SECRET_KEY'],                        # required
      :region                 => ENV['AMAZON_REGION'],                  # optional, defaults to 'us-east-1'
    }
    config.fog_directory  = ENV['S3_BUCKET']                          # required
    config.fog_public     = true
    config.permissions = 0600
  end
end
