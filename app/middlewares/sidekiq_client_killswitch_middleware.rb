class SidekiqClientKillswitchMiddleware
  def call(worker, _, queue, _)
    return false if kill_by_queue?(queue) || kill_by_worker?(worker)

    yield
  end

  private def kill_by_queue?(queue)
    ENV.fetch("SIDEKIQ_KILLSWITCH_QUEUES", "").split(",").include?(queue)
  end

  private def kill_by_worker?(worker)
    ENV.fetch("SIDEKIQ_KILLSWITCH_WORKERS", "").split(",").include?(worker)
  end
end
