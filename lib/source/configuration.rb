module Poutineer
  def self.configuration
    raise StandardError, "credentials are empty" if Rails.application.credentials.public_send(Rails.env).nil?

    Rails.application.credentials.public_send(Rails.env).with_indifferent_access
  end

  def self.redis_sidekiq_server_connection
    @redis_sidekiq_server_connection ||= ConnectionPool.new(:size => redis_pool_size(:sidekiq_server), :timeout => 5) do
      Redis.new(:driver => :hiredis, **redis_configuration(:server))
    end
  end

  def self.redis_sidekiq_client_connection
    @redis_sidekiq_client_connection ||= ConnectionPool.new(:size => redis_pool_size(:sidekiq_client), :timeout => 5) do
      Redis.new(:driver => :hiredis, **redis_configuration(:sidekiq))
    end
  end

  def self.redis_objects_connection
    @redis_objects_connection ||= ConnectionPool.new(:size => redis_pool_size(:objects), :timeout => 5) do
      Redis.new(:driver => :hiredis, **redis_configuration(:objects))
    end
  end

  def self.redis_cache_connection
    @redis_cache_connection ||= ConnectionPool.new(:size => redis_pool_size(:cache), :timeout => 5) do
      Redis.new(:driver => :hiredis, **redis_configuration(:cache))
    end
  end

  def self.redis_lock_connection
    @redis_lock_connection ||= Redlock::Client.new([
      ConnectionPool::Wrapper.new(:size => redis_pool_size(:lock), :timeout => 5) do
        Redis.new(:driver => :hiredis, **redis_configuration(:lock))
      end
    ])
  end

  def self.redis_pool_size(name)
    Poutineer.configuration.fetch_deep(:redis, name, :pool)
  end

  def self.redis_configuration(name)
    {
      :host => ENV.fetch("REDIS_#{name.to_s.upcase}_HOST", "none"),
      :database => ENV.fetch("REDIS_#{name.to_s.upcase}_DATABASE", "0")
    }
  end
end
