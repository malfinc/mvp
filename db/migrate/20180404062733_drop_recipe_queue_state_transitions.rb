class DropRecipeQueueStateTransitions < ActiveRecord::Migration[5.1]
  def change
    drop_table(:recipe_queue_state_transitions)
  end
end
