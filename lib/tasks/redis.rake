namespace :redis do
  task :drop => :environment do
    Blank::REDIS_SIDEKIQ_SERVER_CONNECTION_POOL.with(&:flushdb)
    Blank::REDIS_SIDEKIQ_CLIENT_CONNECTION_POOL.with(&:flushdb)
    Blank::REDIS_OBJECTS_CONNECTION_POOL.with(&:flushdb)
    Blank::REDIS_CACHE_CONNECTION_POOL.with(&:flushdb)
    # Blank::REDIS_REDLOCK_CONNECTION_POOL.with(&:flushdb)
    # TODO: Figure out how to clear redlock?
  end
end
