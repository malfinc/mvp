class SubmissionPolicy < ApplicationPolicy
  class Scope < ApplicationScope
    def resolve
      case role
      when "moderator", "administrator" then scope.all
      else []
      end
    end
  end

  def index?
    account.role_state?(:moderator) || account.role_state?(:administrator)
  end
end
