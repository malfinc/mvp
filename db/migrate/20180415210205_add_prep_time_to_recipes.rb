class AddPrepTimeToRecipes < ActiveRecord::Migration[5.1]
  def change
    add_column(:recipes, :prep_time, :integer, :null => false)
  end
end
