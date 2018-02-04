class RecipeQueueStateTransition < ApplicationRecord
  belongs_to :recipe

  validates_presence_of :to
end
