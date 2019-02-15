class PaymentTypePolicy < ApplicationPolicy
  class Scope < ApplicationScope
    def resolve
      relation.all
    end
  end

  def show?
    only_logged_in
  end

  def index?
    only_logged_in
  end
end
