class CreateRecipes < ActiveRecord::Migration[5.1]
  def change
    create_table(:recipes, :id => :uuid) do |table|
      table.text(:name, :null => false)
      table.citext(:slug, :null => false)
      table.citext(:moderation_state, :null => false)
      table.text(:description, :null => false)
      table.uuid(:author_id, :null => false)
      table.text(:ingredients, :array => true, :null => false, :default => [])
      table.text(:instructions, :array => true, :null => false, :default => [])
      table.integer(:cook_time, :null => false)
      table.integer(:prep_time, :null => false)
      table.timestamps(:index => true, :null => false)

      table.index(:author_id)
      table.index(:moderation_state)
      table.index(:slug, :unique => true)

      table.foreign_key(:accounts, :column => :author_id)
    end
  end
end
