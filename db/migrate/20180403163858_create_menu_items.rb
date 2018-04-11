class CreateMenuItems < ActiveRecord::Migration[5.1]
  def change
    create_table :menu_items, id: :uuid do |table|
      table.string :name, null: false
      table.citext :slug, null: false
      table.string :description, null: false
      table.string :moderation_state, null: false
      table.uuid :establishment_id, null: false
      table.timestamps

      table.index :slug
      table.index :moderation_state
      table.index :establishment_id
      table.foreign_key :establishments, column: :establishment_id
    end
  end
end
