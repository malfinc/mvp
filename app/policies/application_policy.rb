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

    private def fresh?
      requester.onboarding_state?(:fresh)
    end

    private def completed?
      requester.onboarding_state?(:completed)
    end

    private def administrator?
      requester.role_state?(:administrator)
    end

    private def guest?
      requester.role_state?(:guest)
    end

    private def user?
      requester.role_state?(:user)
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

  private def fresh
    requester.onboarding_state?(:fresh)
  end

  private def completed
    requester.onboarding_state?(:completed)
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
    requester.role_state?(:guest)
  end

  private def users
    requester.role_state?(:user)
  end

  private def only_logged_out
    requester.id.nil?
  end
end
