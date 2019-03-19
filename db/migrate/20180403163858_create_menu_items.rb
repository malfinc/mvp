class CreateMenuItems < ActiveRecord::Migration[5.2]
  def change
    create_table(:menu_items, :id => :uuid) do |table|
      table.text(:name, :null => false)
      table.citext(:slug, :null => false)
      table.text(:description, :null => false)
      table.citext(:moderation_state, :null => false)
      table.uuid(:establishment_id, :null => false)
      table.timestamps

      table.index(:slug)
      table.index(:moderation_state)
      table.index(:establishment_id)
      table.foreign_key(:establishments, :column => :establishment_id)
    end
  end
end
