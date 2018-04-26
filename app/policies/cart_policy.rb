class CartPolicy < ApplicationPolicy
  class Scope < ApplicationScope
    def resolve
      return relation.where(account: requester) unless administrator?

      relation.none
    end
  end

  def show?
    guests || users || administrators
  end

  def index?
    administrators
  end
end
