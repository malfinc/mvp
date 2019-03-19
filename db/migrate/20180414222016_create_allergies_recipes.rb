class CreateAllergiesRecipes < ActiveRecord::Migration[5.2]
  def change
    create_join_table(:allergies, :recipes) do |table|
      table.belongs_to(:allergy, :foreign_key => true, :null => false)
      table.belongs_to(:recipe, :foreign_key => true, :null => false)

      table.index([:recipe_id, :allergy_id], :unique => true)
    end
  end
end
