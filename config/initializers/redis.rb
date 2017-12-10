REDIS_CONNECTION_POOL = ConnectionPool.new(size: ENVied.REDIS_POOL_SIZE, timeout: 5) do
  ::Redis.connect(url: ENVied.REDIS_URL)
end
