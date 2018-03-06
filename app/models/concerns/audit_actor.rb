module AuditActor
  extend ActiveSupport::Concern

  included do
    attr_accessor :audit_actor
  end

  def audit_actor_id
    raise ArgumentError, "missing an actor" unless audit_actor.present?

    audit_actor.id
  end
end
