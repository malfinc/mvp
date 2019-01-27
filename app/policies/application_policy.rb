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
    if respond_to?("#{name}_readable?")
      public_send("#{name}_readable?")
    else
      noone
    end
  end

  def write_attribute?(name)
    if respond_to?("#{name}_writable?")
      public_send("#{name}_writable?")
    else
      noone
    end
  end

  private def read_relation?(association)
    record.public_send(association).model.policy_class.const_defined?("Scope") && respond_to?("read_#{name}?")
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
    record.respond_to?(:owner) && actor == record.owner
  end

  private def yourself?
    actor == record
  end

  private def administrator?
    actor.role_state?(:administrator)
  end
end
