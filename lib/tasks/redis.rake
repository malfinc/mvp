namespace :redis do
  task :drop => :environment do
    # Blank::REDIS_REDLOCK_CONNECTION_POOL.with(&:flushdb)
    # TODO: Figure out how to clear redlock?
    BlankApiRails::REDIS_SIDEKIQ_SERVER_CONNECTION.with(&:flushdb)
    BlankApiRails::REDIS_SIDEKIQ_CLIENT_CONNECTION.with(&:flushdb)
    BlankApiRails::REDIS_OBJECTS_CONNECTION.with(&:flushdb)
    BlankApiRails::REDIS_CACHE_CONNECTION.with(&:flushdb)
  end
end
