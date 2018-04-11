class CreateDietMenuItems < ActiveRecord::Migration[5.1]
  def change
    create_join_table :diets, :menu_items do |table|
      table.references :diet, type: :bigint, index: true, foreign_key: true, null: false
      table.references :menu_item, type: :uuid, index: true, foreign_key: true, null: false

      table.index [:diet_id, :menu_item_id], unique: true
    end
  end
end
