require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ContractorManagement
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # don't generate RSpec tests for views and helpers
    config.generators do |g|

      g.test_framework :rspec, fixture: true
      g.fixture_replacement :factory_girl, dir: 'spec/factories'


      g.view_specs false
      g.helper_specs false
    end

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Eastern Time (US & Canada)'

    # Do not include all helpers in every controller.
    config.action_controller.include_all_helpers = false

    # Use bootstrap markup for fields with errors.
    config.action_view.field_error_proc = Proc.new{|html_tag,instance|
      "<div class=\"has-error\">#{html_tag}</div>".html_safe
    }

    config.action_mailer.default_options = {from: 'Gannett Contractor Management <dnrespond@gannett.com>'}
    config.action_mailer.default_url_options = {host: 'carriers.gannett.com'}

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Use ruby-implemented CSS/JS compressors.
    # NOTE: The JavaScript compressor needs to respond to +compress+ instead of +minimize+.
    # See:  http://guides.rubyonrails.org/asset_pipeline.html#using-your-own-compressor
    config.assets.css_compressor = :sass
    config.assets.js_compressor = :uglifier
  end
end
