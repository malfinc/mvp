class PaymentPolicy < ApplicationPolicy
  class Scope < ApplicationScope
    def resolve
      return relation.where(:account => actor) unless administrator?

      relation.none
    end
  end

  def show?
    only_logged_in
  end

  def create?
    only_logged_in
  end
end
