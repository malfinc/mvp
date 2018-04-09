class RemovePublisherIdFromRecipes < ActiveRecord::Migration[5.1]
  def change
    safety_assured do
      remove_column :recipes, :publisher_id
    end
  end
end
