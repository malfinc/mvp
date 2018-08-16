module Moderated
  extend(ActiveSupport::Concern)

  def contributor_usernames
    contributors.pluck(:username).to_sentence
  end

  private def allowed_to_publish?
    actor.onboarding_state?(:completed)
  end

  private def allowed_to_autopublish?
    actor.role_state?(:administrator)
  end

  private def allowed_to_deny?
    actor.role_state?(:administrator)
  end

  private def allowed_to_approve?
    actor.role_state?(:administrator)
  end

  private def allowed_to_remove?
    actor.role_state?(:administrator)
  end

  included do
    include(AuditedWithTransitions)

    has_many(:contributors, :through => :versions, :class_name => "Account", :source => :actor)

    state_machine(:moderation_state, :initial => :draft) do
      event(:publish) do
        transition(:draft => :queued, :if => :allowed_to_publish?)
      end

      event(:deny) do
        transition(:queued => :draft, :if => :allowed_to_deny?)
      end

      event(:remove) do
        transition(:published => :draft, :if => :allowed_to_remove?)
      end

      event(:approve) do
        transition(:queued => :published, :if => :allowed_to_approve?)
      end

      before_transition(:do => :version_transition)
    end
  end
end
