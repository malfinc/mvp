module AuditedWithTransitions
  extend(ActiveSupport::Concern)

  included do
    include(Audited)

    attr_accessor(:transitions)

    has_paper_trail(
      :class_name => "Version",
      :meta => {
        :transitions => :transitions
      }
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
