if Rails.env.production?
  Bugsnag.configure do |configuration|
    configuration.auto_notify = Rails.env.production?
    configuration.auto_capture_sessions = Rails.env.production?
    configuration.api_key = ENV.fetch("BUGSNAG_API_KEY", nil)
    configuration.app_version = ENV.fetch("HEROKU_RELEASE_VERSION", SecureRandom.uuid)
    configuration.notify_release_stages = ["production"]
  end
end
