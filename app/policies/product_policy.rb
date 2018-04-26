class ProductPolicy < ApplicationPolicy
  class Scope < ApplicationScope
    def resolve
      relation.none
    end
  end

  def index?
    guests || users || administrators
  end

  def show?
    guests || users || administrators
  end

  def update?
    administrators
  end
end
