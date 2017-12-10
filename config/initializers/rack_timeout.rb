if Rails.env.production?
  Rack::Timeout.service_timeout = 15
end
