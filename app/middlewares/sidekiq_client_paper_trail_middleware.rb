class SidekiqClientPaperTrailMiddleware
  def call(_, job, _, _)
    job["chain_id"] ||= SecureRandom.uuid()
    job["paper_trail"] ||= {
      "whodunnit" => PaperTrail.request.whodunnit,
      "metadata" => PaperTrail.request.controller_info
    }

    yield
  end
end
