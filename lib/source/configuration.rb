  REDIS_SIDEKIQ_SERVER_CONNECTION_POOL = ConnectionPool.new(:size => Integer(ENV.fetch("REDIS_SIDEKIQ_SERVER_POOL_SIZE")), :timeout => 5) do
module BlankApiRails
    ::Redis.new(:driver => :hiredis, :url => ENV.fetch("REDIS_SIDEKIQ_URL"))
  end
  REDIS_SIDEKIQ_CLIENT_CONNECTION_POOL = ConnectionPool.new(:size => Integer(ENV.fetch("REDIS_SIDEKIQ_CLIENT_POOL_SIZE")), :timeout => 5) do
    ::Redis.new(:driver => :hiredis, :url => ENV.fetch("REDIS_SIDEKIQ_URL"))
  end
  REDIS_OBJECTS_CONNECTION_POOL = ConnectionPool.new(:size => Integer(ENV.fetch("REDIS_OBJECTS_POOL_SIZE")), :timeout => 5) do
    ::Redis.new(:driver => :hiredis, :url => ENV.fetch("REDIS_OBJECTS_URL"))
  end
  REDIS_CACHE_CONNECTION_POOL = ConnectionPool.new(:size => Integer(ENV.fetch("REDIS_CACHE_POOL_SIZE")), :timeout => 5) do
    ::Redis.new(:driver => :hiredis, :url => ENV.fetch("REDIS_CACHE_URL"))
  end
  REDIS_LOCK_CONNECTION = Redlock::Client.new([
    ConnectionPool::Wrapper.new(:size => Integer(ENV.fetch("REDIS_LOCK_POOL_SIZE")), :timeout => 5) do
      ::Redis.new(:driver => :hiredis, :url => ENV.fetch("REDIS_LOCK_URL"))
    end
  ])
end
