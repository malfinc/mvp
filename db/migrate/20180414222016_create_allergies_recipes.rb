class CreateAllergiesRecipes < ActiveRecord::Migration[5.2]
  def change
    create_join_table(:allergies, :recipes) do |table|
      table.references(:allergy, :type => :bigint, :index => true, :foreign_key => true, :null => false)
      table.references(:recipe, :type => :uuid, :index => true, :foreign_key => true, :null => false)

      table.index([:recipe_id, :allergy_id], :unique => true)
    end
  end
end
