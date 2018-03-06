class RecipeQueueStateTransition < ApplicationRecord
  belongs_to :recipe
  belongs_to :audit_actor, class_name: "Account"

  validates_presence_of :audit_actor_id
  validates_presence_of :event
  validates_presence_of :from
  validates_presence_of :to
end
