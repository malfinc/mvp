class SidekiqClientPaperTrailMiddleware
  def call(_, job, _, _)
    job["chain_id"] ||= SecureRandom.uuid()

    Rails.logger.tagged("chain=#{job.fetch("chain_id")}") do
      if PaperTrail.request.whodunnit.blank?
        Rails.logger.warn("No PaperTrail whodunnit available")
        return false
      end

      if PaperTrail.request.controller_info.blank?
        Rails.logger.warn("No PaperTrail metadata available")
        return false
      end

      job["paper_trail"] ||= {
        "whodunnit" => PaperTrail.request.whodunnit,
        "metadata" => PaperTrail.request.controller_info
      }

      yield
    end
  end
end
