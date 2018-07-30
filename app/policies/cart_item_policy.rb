class CartItemPolicy < ApplicationPolicy
  class Scope < ApplicationScope
    def resolve
      return relation.where(:account => actor, :cart => actor.unfinished_cart) unless administrator?

      relation.none
    end
  end

  def show?
    only_logged_in
  end

  def create?
    only_logged_in
  end

  def index?
    only_logged_in
  end
end
