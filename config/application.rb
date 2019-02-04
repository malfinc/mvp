require_relative("boot")

require("rails")

# Pick the frameworks you want:
require("active_model/railtie")
require("active_job/railtie")
require("active_record/railtie")
require("action_controller/railtie")
require("action_mailer/railtie")
require("action_view/railtie")
require("action_cable/engine")
require("active_storage/engine")
# require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

require("net/http")
require("open-uri")
require("ostruct")

require_relative("../lib/source")

module BlankApiRails
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults(5.2)

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    config.generators do |generator|
      # Don't generate system test files
      generator.system_tests = nil

      # Don't generate asset files
      generator.assets = false

      # Don't generate helper files
      generator.helper = false

      # by default tables should have uuid primary keys
      generator.orm(:active_record, :primary_key_type => :uuid)
    end

    # Set the http-level caching
    config.action_controller.perform_caching = true

    # Don't include all helpers in every controller
    config.action_controller.include_all_helpers = false

    # Generate an SQL file based on the database
    config.active_record.schema_format = :sql

    # The ActiveJob adapter
    config.active_job.queue_adapter = :sidekiq
    # config.active_job.queue_name_prefix = "blank_#{Rails.env}"

    # Cache mail views
    config.action_mailer.perform_caching = true

    # Set cache control headers for all assets served from rails
    config.public_file_server.headers = {
      "Cache-Control" => "public, max-age=#{Integer(1.week.seconds)}"
    }

    # Set the application-level cache
    config.cache_store = [
      :redis_cache_store,
      {
        :driver => :hiredis,
        :expires_in => 30.minutes,
        :compress => true,
        :redis => Blank::REDIS_CACHE_CONNECTION_POOL
      }
    ]

    unless Rails.env.test?
      # Set a tag-based logger to STDOUT
      config.logger = ActiveSupport::TaggedLogging.new(
        ActiveSupport::Logger.new(STDOUT)
      )
    end

    # Uses the tags defined below to create logs that are easily grep-able. Each
    # of the below adds one informational piece to each logline. These will appear
    # for HTTP requests
    config.log_tags = [
      # Log the time of the log, in internet format
      ->(_) do
        "time=#{Time.now.iso8601}"
      end,

      # Log the remote ip address from the request
      ->(request) do
        if request.remote_ip
          "remote-ip=#{request.remote_ip}"
        end
      end,

      # Log the session id of the request, if cookies exist
      ->(request) do
        if request.cookie_jar&.encrypted&.fetch(config.session_options.fetch(:key))&.key?("session_id")
          "session-id=#{request.cookie_jar.encrypted.fetch(config.session_options.fetch(:key)).fetch("session_id")}"
        end
      end,

      # Log the request id of the request, supplied by the infrastructure
      ->(request) do
         if request.request_id.present?
          "context-id=#{request.request_id}"
         end
      end
    ]

    # These are the log tags we want to set for ActionCable
    config.action_cable.log_tags = [
      :action_cable,
      ->(request) do
        request.uuid
      end
    ]

    # Review apps have specific domains that we can't replicate, yet
    host = if ENV.key?("HEROKU_PARENT_APP_NAME")
      "#{ENV.fetch("HEROKU_APP_NAME")}.herokuapp.com"
    else
      ENV.fetch("RAILS_HOST")
    end

    # We have an assigned port for production
    port = unless Rails.env.production?
      ENV.fetch("PORT")
    end

    # Set the url options for controllers
    Rails.application.config.action_controller.default_url_options = {
      :host => host,
      :port => port
    }.compact

    # Set the url options for mailers
    Rails.application.config.action_mailer.default_url_options = {
      :host => host,
      :port => port
    }.compact
  end
end
