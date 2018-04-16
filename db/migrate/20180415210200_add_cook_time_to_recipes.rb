class AddCookTimeToRecipes < ActiveRecord::Migration[5.1]
  def change
    add_column :recipes, :cook_time, :integer, null: false
  end
end
