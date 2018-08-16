class ApplicationOperation
  include(ActionOperation)

  attr_accessor :operation_id
  attr_accessor :step_id

  def around_steps(**)
    self.operation_id = SecureRandom.uuid
    Rails.logger.tagged("operation-id=#{operation_id}") do
      yield
    end
  end

  def around_step(**)
    self.step_id = SecureRandom.uuid
    Rails.logger.tagged("step-id=#{step_id}") do
      yield
    end
  end

  def around_task(step:, **)
    Rails.logger.debug("Working on #{step.receiver}##{step.name}")

    ApplicationRecord.transaction(:requires_new => true) do
      yield
    end
  end

  private def database_lock!(resource:)
    LockOperation.(:resource => resource, :type => :row)
  end

  private def global_lock!(resource:, name:, expires_in:)
    global_locks[[resource.to_gid, name]] = LockOperation.(:resource => resource, :name => name, :type => :soft, :expires_in => expires_in).fetch(:lock)
  end

  private def global_unlock!(resource:, name:)
    UnlockOperation.(:lock => global_locks.delete([resource.to_gid, name]), :type => :soft)
  end

  private def global_locks
    @global_locks ||= {}
  end
end
