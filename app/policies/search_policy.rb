class SearchPolicy < ApplicationPolicy
  class Scope < ApplicationScope
    def resolve
      relation.all
    end
  end

  def index?
    everyone
  end

  def show?
    everyone
  end

  def create?
    everyone
  end
end
