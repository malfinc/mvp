class CartItemPolicy < ApplicationPolicy
  class Scope < ApplicationScope
    def resolve
      return relation.where(account: requester, cart: requester.fresh_cart) unless administrator?

      relation.none
    end
  end

  def show?
    guests || users || administrator
  end

  def create?
    everyone
  end

  def index?
    everyone
  end
end
