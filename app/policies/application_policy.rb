class ApplicationPolicy
  class ApplicationScope
    attr_reader :account
    attr_reader :scope

    def initialize(account, scope)
      @account = account
      @scope = scope
    end

    def resolve
      scope.none
    end

    private def role
      account.role_state
    end
  end

  attr_reader :account, :record

  def initialize(account, record)
    @account = account
    @record = record
  end

  def index?
    false
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def scope
    Pundit.policy_scope!(account, record.class)
  end
end
