class CreateMenuItems < ActiveRecord::Migration[5.2]
  def change
    create_table(:menu_items) do |table|
      table.text(:name, :null => false)
      table.citext(:slug, :null => false)
      table.text(:description, :null => false)
      table.citext(:moderation_state, :null => false)
      table.belongs_to(:establishment, :foreign_key => true, :null => false)
      table.timestamps

      table.index(:slug)
      table.index(:moderation_state)
    end
  end
end
