class SidekiqServerPaperTrailMiddleware
  def call(_, job, _)
    PaperTrail.request(:whodunnit => job.fetch("paper_trail").fetch("whodunnit"), :controller_info => {:group_id => job.fetch("paper_trail").fetch("metadata").fetch("group_id"), :actor_id => job.fetch("paper_trail").fetch("metadata").fetch("actor_id")}) do
      yield
    end
  end
end
