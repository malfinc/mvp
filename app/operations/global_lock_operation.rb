class GlobalLockOperation < ApplicationOperation
  task :write
  error :unlock
  error :reraise

  schema :write do
    field :resource, type: Types::Any
    field :type, type: Types::Coercable::String
    field :name, type: Types::Coercable::String.optional
    field :expires_in, type: Types::Integer.optional
    field :expires_at, type: Types.Instance(DateTime).optional
  end
  def write(state:)
    case state.type
    when :row then state.resource.lock!
    when :soft then Redlock.new("???")
    else raise ArgumentError, "unknown type of lock #{state.type}"
    end
  end

  def unlock(exception:, **)
    Rails.logger.warn("Unlocking due to error!")

    case state.type
    when :soft then Redlock.new("???")
    end
  end
end
