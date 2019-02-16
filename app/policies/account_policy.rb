class AccountPolicy < ApplicationPolicy
  class Scope < ApplicationScope
    def resolve
      return relation if actor.role_state?(:administrator)

      relation.where(:id => actor.id)
    end
  end

  def show?
    only_logged_in
  end

  def index?
    everyone
  end

  def create?
    only_logged_out
  end

  def update?
    only_logged_in
  end
end
