class SessionPolicy < ApplicationPolicy
  class Scope < ApplicationScope
    def resolve
      relation
    end
  end
end
