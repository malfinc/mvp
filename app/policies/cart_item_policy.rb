class CartItemPolicy < ApplicationPolicy
  class Scope < ApplicationScope
    def resolve
      return relation.where(account: requester) if requester.present?

      relation.none
    end
  end

  def show?
    owner(:account)
  end

  def create?
    everyone
  end

  def index?
    everyone
  end
end
