module RedisBacked
  extend(ActiveSupport::Concern)

  included do
    include(Redis::Objects)
  end

  class_methods do
    def redis_value(*arguments)
      redis_attribute(:set, *arguments)
    end

    def redis_set(*arguments)
      redis_attribute(:set, *arguments)
    end

    def redis_attribute(type, name, *options)
      public_send(type, name, *options)

      redis_accessors = Module.new do
        define_method("#{name}_redis_value") do
          if instance_variable_defined?("@#{name}")
            instance_variable_get("@#{name}")
          else
            public_send(:updated_at=, Time.zone.now) if respond_to?(:updated_at)
            instance_variable_set(
              "@#{name}",
              Redis::Value.new(redis_field_key(name), redis_field_redis(name), redis_options(name))
            )
          end
        end

        private "#{name}_redis_value"

        define_method(name.to_s) do
          __send__("#{name}_redis_value").value
        end

        define_method("#{name}=") do |value|
          public_send(:updated_at=, Time.zone.now) if respond_to?(:updated_at)
          __send__("#{name}_redis_value").value = value
        end
      end

      include(redis_accessors)
    end
  end
end
