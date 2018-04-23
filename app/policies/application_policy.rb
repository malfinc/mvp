class ApplicationPolicy
  class ApplicationScope
    attr_reader :requester, :relation

    def initialize(requester, relation)
      @requester = requester || RequesterNull.new
      @relation = relation
    end

    def resolve
      relation.none
    end
  end

  attr_reader :requester, :record

  def initialize(requester, record)
    @requester = requester || RequesterNull.new
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
    Pundit.policy_scope!(requester, record.class)
  end

  private def converted
    record.onboarding_state?(:converted)
  end

  private def completed
    requester.onboarding_state?(:completed)
  end

  private def owner_by(field)
    requester == record.public_send(field)
  end

  private def administrators
    requester.role_state?(:administrator)
  end

  private def everyone
    true
  end

  private def noone
    false
  end

  private def guests
    requester.role_state(:user) && requester.onboarding_state?(:fresh)
  end

  private def users
    requester.role_state?(:user) && !requester.onboarding_state?(:fresh)
  end
end
