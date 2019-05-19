# source 'https://artifactory.gannettdigital.com/artifactory/api/gems/ecom-feature-all-gems/' do
source 'https://rubygems.org' do

  # Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
  gem 'rails', '4.2.8'
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'
  # Use SCSS for stylesheets
  gem 'sass-rails', '~> 5.0.6'

  gem 'uglifier', '>= 1.3.0'
  gem 'therubyracer'

  gem 'puma'

  # Use jquery as the JavaScript library
  gem 'jquery-rails'
  # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
  gem 'jbuilder', '~> 2.0'
  # bundle exec rake doc:rails generates the API under doc/api.
  # group :doc do
  #   gem 'sdoc', '~> 0.4.0'
  # end

  gem 'nokogiri', '1.8.2'
  # For simple models, not backed by DB tables.
  gem 'active_attr'

  # For more performant JSON encoding.
  gem 'oj', '3.0.0'
  #
  # # For integrating "oj" with Rails 4.1+
  # gem 'oj_mimic_json'

  # For more performant HTML escaping.
  # See: http://marianposaceanu.com/articles/improve-rails-performance-by-adding-a-few-gems
  # See: https://github.com/brianmario/escape_utils
  # gem 'escape_utils'

  # For more performant String#blank?
  # See: http://marianposaceanu.com/articles/improve-rails-performance-by-adding-a-few-gems
  # See: https://github.com/SamSaffron/fast_blank
  # gem 'fast_blank'

  # Official SASS-compatible bootstrap.
  gem 'bootstrap-sass', '~> 3.3.6'

  group :production do
    gem 'newrelic_rpm'
    # logging in DEV with puma goes to STDOUT.  Force the logs here in production to log correctly in the docker containers...
    gem 'rails_stdout_logging'
  end

  gem 'json'
  # NOTE: We cannot use this because it requires exec_js
  #gem 'autoprefixer-rails' # Recommended by bootstrap-sass developers for automatic browser prefixed CSS.

  gem 'gci-simple-encryption', '~> 0.1.3'
  gem 'silencer', '~> 1.0'

  # gem 'commerce-pipeline', path: '../commerce-pipeline'
  # gem 'commerce-pipeline', '3.0.0.pre6'
  gem 'commerce-pipeline', path: 'vendor/gems/commerce-pipeline'


  # gem 'commerce-app-status', path: '../app_status'
  # gem 'commerce-app-status', '~> 1.2'
  gem 'commerce-app-status', path: 'vendor/gems/commerce-app-status'


  gem 'silencer', '~> 1.0'
  gem 'vault'

  group :development, :test do
    gem 'awesome_print'
    gem 'spring-commands-rspec'
    gem 'spring'
    gem 'factory_girl_rails'
    gem 'rspec-rails'
    gem 'guard-rspec'
    gem 'rb-fchange', :require=>false
    gem 'rb-fsevent', :require=>!!(`uname` =~ /Darwin/)
    gem 'rb-inotify', :require=>false

    gem 'simplecov'
  end

  # Use ActiveModel has_secure_password
  # gem 'bcrypt', '~> 3.1.7'

  # Use unicorn as the app server
  # gem 'unicorn'

  # Use Capistrano for deployment
  # gem 'capistrano-rails', group: :development

end
