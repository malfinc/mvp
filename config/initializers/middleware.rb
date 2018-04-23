BlankApiRails::Application.config.middleware.tap do |middleware|
  middleware.insert_before Warden::Manager, ActionDispatch::Cookies
  middleware.insert_before Warden::Manager, ActionDispatch::Session::CookieStore, key: '_blank-api-rails_key'
  middleware.insert_before Warden::Manager, Rack::AuthenticationBearer, &Base64.method(:urlsafe_decode64)
  middleware.use Rack::Deflater
  middleware.use Rack::Attack
end
