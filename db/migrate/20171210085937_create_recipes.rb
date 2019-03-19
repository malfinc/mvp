class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table(:recipes) do |table|
      table.text(:name, :null => false)
      table.citext(:slug, :null => false)
      table.citext(:moderation_state, :null => false)
      table.text(:description, :null => false)
      table.belongs_to(:author, :null => false, :foreign_key => {:to_table => :accounts})
      table.text(:ingredients, :array => true, :null => false, :default => [])
      table.text(:instructions, :array => true, :null => false, :default => [])
      table.integer(:cook_time, :null => false)
      table.integer(:prep_time, :null => false)
      table.timestamps(:index => true, :null => false)

      table.index(:moderation_state)
      table.index(:slug, :unique => true)
    end
  end
end
