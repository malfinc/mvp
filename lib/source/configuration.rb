module Poutineer
  REDIS_STORE_CONNECTION_POOL = ConnectionPool.new(size: Integer(ENV.fetch("REDIS_STORE_POOL_SIZE")), timeout: 5) do
    ::Redis.new(driver: :hiredis, url: ENV.fetch("REDIS_STORE_URL"))
  end
  REDIS_CACHE_CONNECTION_POOL = ConnectionPool.new(size: Integer(ENV.fetch("REDIS_CACHE_POOL_SIZE")), timeout: 5) do
    ::Redis.new(driver: :hiredis, url: ENV.fetch("REDIS_CACHE_URL"))
  end
end
