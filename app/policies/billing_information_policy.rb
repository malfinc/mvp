class BillingInformationPolicy < ApplicationPolicy
  class Scope < ApplicationScope
    def resolve
      return relation.where(:account => actor) unless administrator?

      relation.none
    end
  end

  def index?
    administrators
  end

  def show?
    only_logged_in
  end

  def create?
    only_logged_in
  end

  def update?
    only_logged_in
  end
end
