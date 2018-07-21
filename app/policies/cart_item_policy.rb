class CartItemPolicy < ApplicationPolicy
  class Scope < ApplicationScope
    def resolve
      return relation.where(:account => requester, :cart => requester.unfinished_cart) unless administrator?

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
