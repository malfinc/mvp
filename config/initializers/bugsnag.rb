Bugsnag.configure do |configuration|
  configuration.auto_notify = Rails.env.production?
  configuration.auto_capture_sessions = Rails.env.production?
  configuration.api_key = ENV["BUGSNAG_API_KEY"]
  configuration.app_version = ENV["HEROKU_RELEASE_VERSION"]
  configuration.notify_release_stages = ["production"]
end
