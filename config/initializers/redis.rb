REDIS_CONNECTION_POOL = ConnectionPool.new(size: Integer(ENV.fetch("REDIS_POOL_SIZE")), timeout: 5) do
  ::Redis.new(driver: :hiredis, url: ENV.fetch("REDIS_URL"))
end
