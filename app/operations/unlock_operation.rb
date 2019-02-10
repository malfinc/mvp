class UnlockOperation < ApplicationOperation
  task(:delete)
  catch(:reraise)

  schema(:delete) do
    field(:lock, :type => Types::Strict::Hash)
    field(:type, :type => Types::Strict::Symbol)
  end
  def delete(state:)
    BlankApiRails.redis_lock_connection.unlock(state.lock)
  end
end
