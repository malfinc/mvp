class AddInstructionsToRecipes < ActiveRecord::Migration[5.1]
  def change
    safety_assured do
      add_column :recipes, :instructions, :string, array: true, null: false, default: []
    end
  end
end
