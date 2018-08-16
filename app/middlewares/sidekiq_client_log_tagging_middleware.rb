class SidekiqClientLogTaggingMiddleware
  def call(worker, job, queue, _)
    Rails.logger.tagged("worker=#{worker}") do
      Rails.logger.tagged("queue=#{queue}") do
        Rails.logger.tagged("chain=#{job.fetch("chain_id")}") do
          Rails.logger.tagged("job=#{job.fetch("jid")}") do
            yield
          end
        end
      end
    end
  end
end
