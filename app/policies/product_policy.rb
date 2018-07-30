class ProductPolicy < ApplicationPolicy
  class Scope < ApplicationScope
    def resolve
      relation.none
    end
  end

  def index?
    only_logged_in
  end

  def show?
    only_logged_in
  end

  def update?
    administrators
  end
end
