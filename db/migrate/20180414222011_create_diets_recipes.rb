class CreateDietsRecipes < ActiveRecord::Migration[5.1]
  def change
    create_join_table :diets, :recipes do |table|
      table.references(:diet, :type => :bigint, :index => true, :foreign_key => true, :null => false)
      table.references(:recipe, :type => :uuid, :index => true, :foreign_key => true, :null => false)

      table.index([:recipe_id, :diet_id], :unique => true)
    end
  end
end
