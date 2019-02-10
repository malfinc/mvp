module BlankApiRails
  def self.configuration
    Rails.application.credentials.public_send(Rails.env).with_indifferent_access
  end

  def self.redis_sidekiq_server_connection
    @redis_sidekiq_server_connection ||= ConnectionPool.new(:size => BlankApiRails.configuration.fetch_deep(:redis, :sidekiq_server, :pool), :timeout => 5) do
      ::Redis.new(:driver => :hiredis, :url => ENV.fetch("REDIS_SIDEKIQ_URI"))
    end
  end

  def self.redis_sidekiq_client_connection
    @redis_sidekiq_client_connection ||= ConnectionPool.new(:size => BlankApiRails.configuration.fetch_deep(:redis, :sidekiq_client, :pool), :timeout => 5) do
      ::Redis.new(:driver => :hiredis, :url => ENV.fetch("REDIS_SIDEKIQ_URI"))
    end
  end

  def self.redis_objects_connection
    @redis_objects_connection ||= ConnectionPool.new(:size => BlankApiRails.configuration.fetch_deep(:redis, :objects, :pool), :timeout => 5) do
      ::Redis.new(:driver => :hiredis, :url => ENV.fetch("REDIS_OBJECTS_URL"))
    end
  end

  def self.redis_cache_connection
    @redis_cache_connection ||= ConnectionPool.new(:size => BlankApiRails.configuration.fetch_deep(:redis, :cache, :pool), :timeout => 5) do
      ::Redis.new(:driver => :hiredis, :url => ENV.fetch("REDIS_CACHE_URL"))
    end
  end

  def self.redis_lock_connection
    @redis_lock_connection ||= Redlock::Client.new([
      ConnectionPool::Wrapper.new(:size => BlankApiRails.configuration.fetch_deep(:redis, :lock, :pool), :timeout => 5) do
        ::Redis.new(:driver => :hiredis, :url => ENV.fetch("REDIS_LOCK_URI"))
      end
    ])
  end
end
