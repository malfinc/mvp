class CreateRecipes < ActiveRecord::Migration[5.1]
  def change
    create_table :recipes, id: :uuid do |table|
      table.text :name, null: false
      table.string :slug, null: false
      table.text :description, null: false
      table.uuid :author_id, null: false
      table.timestamps index: true, null: false

      table.index :slug
      table.index :author_id
      table.foreign_key :accounts, column: :author_id
    end
  end
end
