if Rails.env.production? || Rails.env.staging?
  Rack::Timeout.service_timeout = 25
end
