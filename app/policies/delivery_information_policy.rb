class DeliveryInformationPolicy < ApplicationPolicy
  class Scope < ApplicationScope
    def resolve
      return relation.where(account: requester) unless administrator?

      relation.none
    end
  end

  def index?
    administrators
  end

  def show?
    guests || users || administrators
  end

  def create?
    guests || users || administrators
  end

  def update?
    guests || users || administrators
  end
end
