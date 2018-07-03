class EstablishmentPolicy < ApplicationPolicy
  class Scope < ApplicationScope
    def resolve
      case role
      when "user"
        scope
          .joins(:public_versions)
          .where.has do |query|
            (query.public_versions.actor == account) | (query.moderation_state == "published")
          end
          .distinct
      when "administrator"
        scope.all
      when "moderator"
        scope.with_moderation_state([:queued, :published])
      else
        scope.with_moderation_state(:published)
      end
    end
  end

  def index?
    true
  end

  def show?
    true
  end

  def new?
    create?
  end

  def edit?
    update?
  end

  def update?
    administrator? || owner?
  end

  def create?
    converted? || completed? || administrator?
  end

  def destroy?
    owner? || administrator?
  end
end
