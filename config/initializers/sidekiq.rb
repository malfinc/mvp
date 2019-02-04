Sidekiq.configure_server do |config|
  config.redis = BlankApiRails::REDIS_SIDEKIQ_SERVER_CONNECTION
  config.logger = Rails.logger
  config.client_middleware do |chain|
    chain.add(SidekiqClientPaperTrailMiddleware)
    chain.add(SidekiqClientLogTaggingMiddleware)
    chain.add(SidekiqClientKillswitchMiddleware)
  end
  config.server_middleware do |chain|
    chain.add(SidekiqServerLogTaggingMiddleware)
    chain.add(SidekiqServerExceptionHandlerMiddleware)
    chain.add(SidekiqServerPaperTrailMiddleware)
  end
end

Sidekiq.configure_client do |config|
  config.redis = BlankApiRails::REDIS_SIDEKIQ_CLIENT_CONNECTION
  config.logger = Rails.logger
  config.client_middleware do |chain|
    chain.add(SidekiqClientPaperTrailMiddleware)
    chain.add(SidekiqClientKillswitchMiddleware)
    chain.add(SidekiqClientLogTaggingMiddleware)
  end
end
