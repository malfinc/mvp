Rails.application.config.tap do |let|
  # Use a different cache store in production.
  let.cache_store = :redis_store, ENVied.REDIS_URL, { expires_in: 30.minutes }
end
