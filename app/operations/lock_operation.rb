class LockOperation < ApplicationOperation
  task(:create)
  catch(:reraise)

  schema(:create) do
    field(:resource, :type => Types::Any)
    field(:type, :type => Types::Strict::Symbol)
    field(:name, :type => Types::Strict::Symbol.optional)
    field(:expires_in, :type => Types::Strict::Integer.optional)
  end
  def create(state:)
    case state.type
    when :row then state.resource.lock!
    when :soft
      fresh(
        :state => {
          :lock => BlankApiRails::REDIS_LOCK_CONNECTION.lock(key(state.resource.to_gid, state.name), state.expires_in)
        }
      )
    else raise(ArgumentError, "unknown type of lock #{state.type}")
    end
  end

  private def key(*parts)
    parts.compact.join("/")
  end
end
