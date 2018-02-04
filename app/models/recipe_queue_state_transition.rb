class RecipeQueueStateTransition < ApplicationRecord
  belongs_to :recipe

  validates_presence_of :namespace
  validates_presence_of :from
  validates_presence_of :to
end
