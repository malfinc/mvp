namespace :redis do
  task :drop => :environment do
    BlankApiRails::REDIS_SIDEKIQ_SERVER_CONNECTION.with(&:flushdb)
    BlankApiRails::REDIS_SIDEKIQ_CLIENT_CONNECTION.with(&:flushdb)
    BlankApiRails::REDIS_OBJECTS_CONNECTION.with(&:flushdb)
    BlankApiRails::REDIS_CACHE_CONNECTION.with(&:flushdb)
    BlankApiRails::REDIS_LOCK_CONNECTION.client.flushdb
  end
end
