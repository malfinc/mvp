class CreatePrivateVersions < ActiveRecord::Migration[5.1]
  def change
    create_table :private_versions, :id => :bigint do |table|
      table.text(:item_type, :null => false)
      table.bigint(:item_id, :null => false)
      table.text(:event, :null => false)
      table.text(:whodunnit, :null => false)
      table.uuid(:actor_id)
      table.uuid(:group_id, :null => false)
      table.jsonb(:transitions)
      table.json(:object, :null => false, :default => {})
      table.jsonb(:object_changes, :null => false, :default => {})
      table.timestamp(:created_at, :null => false)

      table.index([:item_id, :item_type])
      table.index(:actor_id)
      table.index(:group_id)
      table.index(:created_at)
      table.index(:event)

      table.foreign_key :accounts, column: :actor_id
    end
  end
end
