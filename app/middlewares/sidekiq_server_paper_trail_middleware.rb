class SidekiqServerPaperTrailMiddleware
    PaperTrail.request.whodunnit ||= job.fetch("paper_trail").fetch("whodunnit")
    PaperTrail.request.controller_info ||= {
      :group_id => job.fetch("paper_trail").fetch("metadata").fetch("group_id"),
      :actor_id => job.fetch("paper_trail").fetch("metadata").fetch("actor_id")
    }
    yield
  def call(_, job, _)
  end
end
