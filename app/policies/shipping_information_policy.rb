class ShippingInformationPolicy < ApplicationPolicy
  class Scope < ApplicationScope
    def resolve
      relation.none
    end
  end
end
