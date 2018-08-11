module Audited
  extend(ActiveSupport::Concern)

  def actor
    if PaperTrail.request.controller_info.with_indifferent_access.key?(:actor_id)
      Account.find(PaperTrail.request.controller_info.with_indifferent_access.fetch(:actor_id))
    else
      ActorNull.new
    end
  end

  included do
    has_paper_trail(
      :class_name => "Version"
    )
  end
end
