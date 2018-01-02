Sidekiq.configure_server do |config|
  config.redis = REDIS_CONNECTION_POOL
end

Sidekiq.configure_client do |config|
  config.redis = REDIS_CONNECTION_POOL
end
