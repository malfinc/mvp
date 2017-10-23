require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
# require "action_cable/engine"
# require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

REQUIRED_ENVIRONMENT_VARIABLES = %w[
  RAILS_ENV
  ORIGIN_ENCRYPTION_PRIVATE
  ORIGIN_ENCRYPTION_SALT
  RAILS_SESSION_PRIVATE
  ORIGIN_LOCATION
  WWW_LOCATION
]

raise "You're missing #{REQUIRED_ENVIRONMENT_VARIABLES - ENV.keys} environment variables" if (REQUIRED_ENVIRONMENT_VARIABLES - ENV.keys).any?


module BlankApiRails
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    config.generators do |let|
      let.assets = false
      let.helper = false
    end

    config.action_controller.include_all_helpers = false

    config.active_record.schema_format = :sql
  end
end
