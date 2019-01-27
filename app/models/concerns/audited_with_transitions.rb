module AuditedWithTransitions
  extend(ActiveSupport::Concern)

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

  included do
    include(Audited)

    attr_accessor(:transitions)
  end

  class_methods do
    private def paper_trail_meta
      {
        :transitions => :transitions
      }
    end
  end
end
