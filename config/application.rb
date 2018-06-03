require_relative "boot"

require "open-uri"
require "ostruct"
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

require_relative "../lib/source"
require_relative "../lib/extensions/rails/console"

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

    config.generators.system_tests = nil
    config.generators.assets = false
    config.generators.helper = false
    config.generators do |generator|
      generator.orm :active_record, primary_key_type: :uuid
    end
    config.action_controller.include_all_helpers = false
    config.active_record.schema_format = :sql
    config.active_job.queue_adapter = :sidekiq
    config.cache_store = :redis_store, { expires_in: 30.minutes, pool: BlankApiRails::REDIS_CACHE_CONNECTION_POOL }
    config.log_tags = [
      lambda { |request| "time=#{Time.now.iso8601}" },
      lambda do |request|
        "remote-ip=#{request.remote_ip}" if request.remote_ip
      end,
      lambda do |request|
        if request.cookie_jar.encrypted.try!(:[], config.session_options[:key]).try!(:[], "session_id")
          "session-id=#{request.cookie_jar.encrypted.try!(:[], config.session_options[:key]).try!(:[], "session_id")}"
        end
      end,
      lambda do |request|
        "request-id=#{request.request_id}" if request.request_id
      end
    ]

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
        port: ENV.fetch("PORT")
      }
    end
  end
end
