class CreateDiets < ActiveRecord::Migration[5.2]
  def change
    create_table(:diets) do |table|
      table.text(:name, :null => false)
      table.timestamps

      table.index(:name, :unique => true)
    end
  end
end
