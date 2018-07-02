class SidekiqClientPaperTrailMiddleware
  def call(_, job, _, _)
    job["chain_id"] ||= SecureRandom.uuid()

    Rails.logger.tagged("group=#{job.fetch("chain_id")}") do
      unless PaperTrail.request.whodunnit.present?
        Rails.logger.warn("No PaperTrail whodunnit available")
        return false
      end

      unless PaperTrail.request.controller_info.present?
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
