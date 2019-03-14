class EstablishmentSearchPolicy < ApplicationPolicy
  class Scope < ApplicationScope
    def resolve
      scope
    end
  end

  def show?
    converted? || completed? || administrator?
  end

  def new?
    create?
  end

  def create?
    converted? || completed? || administrator?
  end
end
