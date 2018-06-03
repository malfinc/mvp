class AccountPolicy < ApplicationPolicy
  class Scope < ApplicationScope
    def resolve
      return relation if requester.role_state?(:administrator)

      relation.where(id: requester.id)
    end
  end

  def show?
    guests || users || administrators
  end

  def index?
    everyone
  end

  def create?
    only_logged_out
  end

  def update?
    guests || users || administrators
  end
end
