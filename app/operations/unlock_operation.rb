class UnlockOperation < ApplicationOperation
  task(:delete)
  catch(:reraise)

  schema(:delete) do
    field(:lock, :type => Types::Strict::Hash)
    field(:type, :type => Types::Strict::Symbol)
  end
  def delete(state:)
    BlankApiRails::REDIS_REDLOCK_CONNECTION_POOL.with do |client|
      client.unlock(state.lock)
    end
  end
end
