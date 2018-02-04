module AuditActor
  extend ActiveSupport::Concern

  included do
    attr_writer :audit_actor
  end

  def audit_actor_id
    audit_actor.id
  end
end
