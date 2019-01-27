class SidekiqServerLogTaggingMiddleware
  def call(worker, job, queue)
    Rails.logger.tagged("worker=#{worker.class.name}") do
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
