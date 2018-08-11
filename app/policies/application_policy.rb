class ApplicationPolicy
  class ApplicationScope
    attr_reader(:actor)
    attr_reader(:relation)

    def initialize(actor, relation)
      @actor = actor || ActorNull.new
      @relation = relation
    end

    def resolve
      relation.none
    end

    private def completed?
      actor.onboarding_state?(:completed)
    end

    private def administrator?
      actor.role_state?(:administrator)
    end

    private def user?
      actor.role_state?(:user)
    end
  end

  attr_reader(:actor)
  attr_reader(:record)

  def initialize(actor, record)
    @actor = actor || ActorNull.new
    @record = record
  end

  def index?
    noone
  end

  def show?
    noone
  end

  def create?
    noone
  end

  def update?
    noone
  end

  def destroy?
    noone
  end

  def scope
    Pundit.policy_scope!(actor, record.class)
  end

  def read_attribute?(name)
    if respond_to?("read_attribute_#{name}?")
      public_send("read_attribute_#{name}?")
    else
      noone
    end
  end

  def write_attribute?(name)
    if respond_to?("write_attribute_#{name}?")
      public_send("write_attribute_#{name}?")
    else
      noone
    end
  end

  private def read_relation?(association)
    if record.public_send(association).model.policy_class.const_defined?("Scope")
      record.public_send(association).model.policy_class.const_get("Scope").new(actor, record.public_send(association))
    else
      record.public_send(association).none
    end
  end

  private def completed
    actor.onboarding_state?(:completed)
  end

  private def administrators
    actor.role_state?(:administrator)
  end

  private def everyone
    true
  end

  private def noone
    false
  end

  private def users
    actor.role_state?(:user)
  end

  private def converted?
    actor.onboarding_state?(:converted)
  end

  private def completed?
    actor.onboarding_state?(:completed)
  end

  private def only_logged_out
    actor.blank?
  end

  private def only_logged_in
    actor.id.present?
  end

  private def owner?
    actor == record.author
  end

  private def administrator?
    account.role_state?(:administrator)
  end
end
