Rack::Timeout.service_timeout = Integer(ENV.fetch("RACK_SERVICE_TIMEOUT")) if Rails.env.production?
