module Poutineer
  module Redis
    def self.sidekiq_server_connection
      @sidekiq_server_connection ||= ConnectionPool.new(:size => pool_size(:sidekiq_server), :timeout => 5) do
        ::Redis.new(:driver => :hiredis, **configuration(:sidekiq))
      end
    end

    def self.sidekiq_client_connection
      @sidekiq_client_connection ||= ConnectionPool.new(:size => pool_size(:sidekiq_client), :timeout => 5) do
        ::Redis.new(:driver => :hiredis, **configuration(:sidekiq))
      end
    end

    def self.objects_connection
      @objects_connection ||= ConnectionPool.new(:size => pool_size(:objects), :timeout => 5) do
        ::Redis.new(:driver => :hiredis, **configuration(:objects))
      end
    end

    def self.cache_connection
      @cache_connection ||= ConnectionPool.new(:size => pool_size(:cache), :timeout => 5) do
        ::Redis.new(:driver => :hiredis, **configuration(:cache))
      end
    end

    def self.lock_connection
      @lock_connection ||= Redlock::Client.new([
        ConnectionPool::Wrapper.new(:size => pool_size(:lock), :timeout => 5) do
          ::Redis.new(:driver => :hiredis, **configuration(:lock))
        end,
      ])
    end

    def self.pool_size(name)
      Poutineer.settings.fetch_deep(:redis, name, :pool)
    end

    def self.configuration(name)
      {
        :host => ENV.fetch("REDIS_#{name.to_s.upcase}_HOST", "none"),
        :database => ENV.fetch("REDIS_#{name.to_s.upcase}_DATABASE", "0"),
      }
    end
  end
end
