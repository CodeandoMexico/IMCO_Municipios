source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.1'

# PostreSQL as DB
gem 'pg'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

gem 'font-awesome-rails'

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails' #para el autocomplletar
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# additional requirements
gem 'bootstrap-sass', '~> 3.3.1'
gem 'autoprefixer-rails'

# authentication and authorization
gem 'devise'
gem 'pundit'

gem 'chosen-rails' #autocompletar
gem 'bootstrap-switch-rails', '~> 3.0.0'


gem 'omniauth-facebook'
gem 'omniauth-linkedin'

gem 'kaminari' #para paginar

# process files
gem 'fog'
gem 'carrierwave'
gem 'mini_magick'


group :development do
  # Thin server
  gem 'thin'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring',        group: :development
  # Better debugging
  gem 'better_errors'
  gem 'binding_of_caller'
  # Seeds
  gem 'seed_dump'
end

group :development, :test do
  # Load env variables
  gem 'figaro'
  gem 'rspec-rails'
  gem 'capybara'
  gem 'launchy'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
end

group :production do
  gem 'unicorn'
  gem 'rails_12factor'
end

# Use debugger
# gem 'debugger', group: [:development, :test]
