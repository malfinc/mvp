class RenameQueueStateToModerationStateOnRecipes < ActiveRecord::Migration[5.1]
  def change
    safety_assured do
      rename_column :recipes, :queue_state, :moderation_state
    end
  end
end
