BlankApiRails::Application.config.middleware.use(Rack::AuthenticationBearer)
BlankApiRails::Application.config.middleware.use(Rack::Deflater)
BlankApiRails::Application.config.middleware.use(Rack::Attack)
