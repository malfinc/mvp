Sidekiq.configure_server do |config|
  config.redis = Poutineer::REDIS_SIDEKIQ_CONNECTION_POOL
end

Sidekiq.configure_client do |config|
  config.redis = Poutineer::REDIS_SIDEKIQ_CONNECTION_POOL
end
