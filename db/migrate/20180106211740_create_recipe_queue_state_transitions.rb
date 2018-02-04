class CreateRecipeQueueStateTransitions < ActiveRecord::Migration[5.1]
  def change
    create_table :recipe_queue_state_transitions, id: :uuid do |table|
      table.uuid :recipe_id, null: false
      table.string :namespace, null: false
      table.string :event, null: false
      table.string :from, null: false
      table.string :to, null: false
      table.timestamp :created_at, null: false

      table.index :recipe_id
      table.foreign_key :recipes, column: :recipe_id
    end
  end
end
