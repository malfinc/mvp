module AuditedTransitions
  extend ActiveSupport::Concern

  included do
    attr_accessor :transitions

    has_paper_trail meta: {
      actor_id: :actor_id,
      transitions: :transitions,
    }
  end

  private def version_transition(transition)
    self.assign_attributes(transitions: transitions || {})
    self.assign_attributes(
      transitions: transitions.
        with_indifferent_access.
        merge({
          transition.attribute => self.transitions.fetch(transition.attribute, []).push(transition.event)
        })
    )
  end
end
