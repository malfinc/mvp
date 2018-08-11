module Audited
  extend(ActiveSupport::Concern)

  included do
    has_paper_trail(
      :class_name => "Version",
      :meta => {
        :actor_id => :actor_id
      }
    )
  end
end
