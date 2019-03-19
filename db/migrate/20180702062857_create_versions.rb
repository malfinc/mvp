class CreateVersions < ActiveRecord::Migration[5.2]
  def change
    create_table(:versions) do |table|
      table.belongs_to(:item, :polymorphic => true, :null => false)
      table.belongs_to(:actor, :null => false, :foreign_key => {:to_table => :accounts})
      table.text(:event, :null => false)
      table.text(:whodunnit, :null => false)
      table.uuid(:context_id, :null => false)
      table.jsonb(:transitions)
      table.jsonb(:object_changes, :null => false, :default => {})
      table.timestamp(:created_at, :null => false)

      table.index(:context_id)
      table.index(:created_at)
      table.index(:event)
    end
  end
end
