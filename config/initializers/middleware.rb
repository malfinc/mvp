BlankApiRails::Application.config.middleware.tap do |middleware|
  middleware.use Rack::AuthenticationBearer, &Base64.method(:urlsafe_decode64)
  middleware.use Rack::Deflater
  middleware.use Rack::Attack
  middleware.use ActionDispatch::Cookies
  middleware.use ActionDispatch::Session::CookieStore, key: '_blank-api-rails_key'
end
