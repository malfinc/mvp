class SidekiqClientPaperTrailMiddleware
  def call(_, job, _, _)
    job["chain_id"] ||= SecureRandom.uuid()

    Rails.logger.tagged("chain=#{job.fetch("chain_id")}") do
      job["paper_trail"] ||= {
        "whodunnit" => PaperTrail.request.whodunnit,
        "metadata" => PaperTrail.request.controller_info
      }

      yield
    end
  end
end
