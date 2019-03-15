class SidekiqClientKillswitchMiddleware
  def call(worker, _, queue, _)
    return false if kill_by_queue?(queue) || kill_by_worker?(worker)

    yield
  end

  private def kill_by_queue?(queue)
    Poutineer.settings.fetch_deep(:sidekiq, :killswitch, :queues).include?(queue)
  end

  private def kill_by_worker?(worker)
    Poutineer.settings.fetch_deep(:sidekiq, :killswitch, :workers).include?(worker)
  end
end
