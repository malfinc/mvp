class CartPolicy < ApplicationPolicy
  class Scope < ApplicationScope
    def resolve
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
    administrator
  end
end
