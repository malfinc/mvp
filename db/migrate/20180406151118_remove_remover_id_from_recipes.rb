class RemoveRemoverIdFromRecipes < ActiveRecord::Migration[5.1]
  def change
    safety_assured do
      remove_column :recipes, :remover_id
    end
  end
end
