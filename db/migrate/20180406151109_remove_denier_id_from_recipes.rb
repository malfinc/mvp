class RemoveDenierIdFromRecipes < ActiveRecord::Migration[5.1]
  def change
    safety_assured do
      remove_column :recipes, :denier_id
    end
  end
end
