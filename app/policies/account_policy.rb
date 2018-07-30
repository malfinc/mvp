class AccountPolicy < ApplicationPolicy
  class Scope < ApplicationScope
    def resolve
      return relation if actor.role_state?(:administrator)

      relation.where(:id => actor.id)
    end
  end

  def show?
    only_logged_in
  end

  def index?
    everyone
  end

  def create?
    only_logged_out
  end

  def update?
    only_logged_in
  end

  def read_attribute_authentication_secret?
    (actor == record) || record.new_record?
  end

  def related_payments(payments = nil)
    PaymentPolicy::Scope.new(actor, payments || record.payments).resolve
  end
end
