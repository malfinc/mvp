class SidekiqClientKillswitchMiddleware
  def call(worker, _, queue, _)
    return false if kill_by_queue?(queue) || kill_by_worker?(worker)

    yield
  end

  private def kill_by_queue?(queue)
    BlankApiRails.configuration.fetch_deep(:sidekiq, :killswitch, :queues).split(",").include?(queue)
  end

  private def kill_by_worker?(worker)
    BlankApiRails.configuration.fetch_deep(:sidekiq, :killswitch, :workers).split(",").include?(worker)
  end
end
