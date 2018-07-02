class SidekiqServerPaperTrailMiddleware
  def call(_, job, _)
    paper_trail = job.fetch("paper_trail")

    raise ApplicationError, "No PaperTrail available" unless paper_trail.present?

    whodunnit = paper_trail.fetch("whodunnit")

    raise ApplicationError, "No PaperTrail whodunnit available" unless whodunnit.present?

    metadata = paper_trail.fetch("metadata")

    raise ApplicationError, "No PaperTrail metadata available" unless metadata.present?

    PaperTrail.request(:whodunnit => whodunnit, :controller_info => {:group_id => metadata.fetch("group_id"), :actor_id => metadata.fetch("actor_id")}) do
      yield
    end
  end
end
