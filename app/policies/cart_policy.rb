class CartPolicy < ApplicationPolicy
  class Scope < ApplicationScope
    def resolve
      relation.none
    end
  end

  def show?
    owner_by(:account) || administrators
  end

  def create?
    users || administrators
  end

  def index?
    administrators
  end
end
