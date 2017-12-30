class CreateRecipes < ActiveRecord::Migration[5.1]
  def change
    create_table :recipes, id: :uuid do |table|
      table.text :name, null: false
      table.string :state, null: false
      table.text :description, null: false
      table.uuid :author_id, null: false
      table.uuid :approver_id
      table.uuid :publisher_id
      table.uuid :denier_id
      table.uuid :remover_id
      table.text :ingredients, array: true, default: [], null: false
      table.timestamps index: true, null: false

      table.index :author_id
      table.index :approver_id
      table.index :publisher_id
      table.index :denier_id
      table.index :remover_id
      table.index :state
      table.foreign_key :accounts, column: :author_id
      table.foreign_key :accounts, column: :approver_id
      table.foreign_key :accounts, column: :publisher_id
      table.foreign_key :accounts, column: :denier_id
      table.foreign_key :accounts, column: :remover_id
    end
  end
end
