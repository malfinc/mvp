class CreateDietsRecipes < ActiveRecord::Migration[5.2]
  def change
    create_join_table(:diets, :recipes) do |table|
      table.belongs_to(:diet, :foreign_key => true, :null => false)
      table.belongs_to(:recipe, :foreign_key => true, :null => false)

      table.index([:recipe_id, :diet_id], :unique => true)
    end
  end
end
