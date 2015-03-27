require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'csv'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PruebaDB
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :es

    # configure mailer
      config.action_mailer.default_url_options = { host: ENV['ACTION_MAILER_HOST'] }
      config.action_mailer.smtp_settings = {
        :user_name => ENV['SMTP_CONFIG_USERNAME'],
        :password => ENV['SMTP_CONFIG_PASSWORD'],
        :domain => ENV['SMTP_CONFIG_DOMAIN'],
        :address => ENV['SMTP_CONFIG_ADDRESS'],
        :port => 587,
        :authentication => :plain,
        :enable_starttls_auto => true
      }

    # devise layout settings
    config.to_prepare do
      # Devise::SessionsController.layout "session.html.erb"
      # Devise::RegistrationsController.layout "session.html.erb"
      # Devise::ConfirmationsController.layout "session.html.erb"
      # Devise::UnlocksController.layout "session.html.erb"
      # Devise::PasswordsController.layout "session.html.erb"
    end

    config.serve_static_assets = true
  end
end
