class ApplicationOperation
  include(ActionOperation)

  def around_steps(**)
    Rails.logger.tagged("operation-id=#{SecureRandom.uuid}") do
      Rails.logger.debug("Started adding cart to product operation")

      yield
    end
  end

  def around_step(**)
    Rails.logger.tagged("step-id=#{SecureRandom.uuid}") do
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
