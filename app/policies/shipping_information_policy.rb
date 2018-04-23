class ShippingInformationPolicy < ApplicationPolicy
  class Scope < ApplicationScope
    def resolve
      relation.none
    end
  end

  def create?
    guests || users || administrators
  end
end
