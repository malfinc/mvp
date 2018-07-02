module AuditedTransitions
  extend ActiveSupport::Concern

  included do
    attr_accessor :transitions

    has_paper_trail(
      :meta => {
        :actor_id => :actor_id,
        :transitions => :transitions
      },
      :class_name => const_get("PAPER_TRAIL_MODEL")
    )
  end

  private def version_transition(transition)
    assign_attributes(:transitions => transitions || {})
    assign_attributes(
      :transitions => transitions
        .with_indifferent_access
        .merge(
          transition.attribute => transitions.fetch(transition.attribute, []).push(transition.event)
        )
    )
  end
end
