class SidekiqClientLogTaggingMiddleware
  def call(worker, job, queue)
    Rails.logger.tagged("worker=#{worker}") do
      Rails.logger.tagged("queue=#{queue}") do
        Rails.logger.tagged("group=#{job["chain_id"]}") do
          Rails.logger.tagged("group=#{job["jid"]}") do
            yield
          end
        end
      end
    end
  end
end
