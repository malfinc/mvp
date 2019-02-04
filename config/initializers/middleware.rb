BlankApiRails::Application.config.middleware.tap do |middleware|
  middleware.insert_before(Warden::Manager, ActionDispatch::Cookies)
  middleware.insert_before(Warden::Manager, ActionDispatch::Session::CookieStore, :key => ENV.fetch("RAILS_COOKIE_KEY"), :expire_after => 14.days)
  middleware.insert_before(Warden::Manager, Rack::AuthenticationBearer, &Base64.method(:urlsafe_decode64))
  middleware.use(Rack::Deflater)
  middleware.use(Rack::Attack)
  # config.middleware.insert_before(Rack::Runtime, Rack::Rewrite) do
  #   rewrite   '/wiki/John_Trupiano',  '/john'
  #   r301      '/wiki/Yair_Flicker',   '/yair'
  #   r302      '/wiki/Greg_Jastrab',   '/greg'
  #   r301      %r{/wiki/(\w+)_\w+},    '/$1'
  # end
end
