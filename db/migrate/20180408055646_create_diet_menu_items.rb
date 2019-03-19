class CreateDietMenuItems < ActiveRecord::Migration[5.2]
  def change
    create_join_table(:diets, :menu_items) do |table|
      table.belongs_to(:diet, :foreign_key => true, :null => false)
      table.belongs_to(:menu_item, :foreign_key => true, :null => false)

      table.index([:diet_id, :menu_item_id], :unique => true)
    end
  end
end
