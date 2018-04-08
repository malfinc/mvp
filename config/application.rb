require_relative 'boot'

require "open-uri"
require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

require 'sidekiq/web'
require_relative "../lib/poutineer"
require_relative "../lib/extensions/simple_form/array_input"

module Poutineer
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Don't generate system test files.
    config.generators.system_tests = nil
    config.generators.assets = false
    config.generators.helper = false
    config.generators do |generator|
      generator.orm :active_record, primary_key_type: :uuid
    end
    config.action_controller.include_all_helpers = false
    config.active_record.schema_format = :sql
    config.active_job.queue_adapter = :sidekiq
    config.cache_store = :redis_store, { expires_in: 30.minutes, pool: Poutineer::REDIS_CACHE_CONNECTION_POOL }

    if ENV.fetch("HEROKU_APP_NAME", nil)
      Rails.application.config.action_mailer.default_url_options = {
        host: "#{ENV.fetch("HEROKU_APP_NAME")}.herokuapp.com"
      }
    elsif Rails.env.production?
      Rails.application.config.action_mailer.default_url_options = {
        host: ENV.fetch("RAILS_HOST")
      }
    else
      Rails.application.config.action_mailer.default_url_options = {
        host: ENV.fetch("RAILS_HOST"),
        port: Integer(ENV.fetch("PORT"))
      }
    end
  end
end
