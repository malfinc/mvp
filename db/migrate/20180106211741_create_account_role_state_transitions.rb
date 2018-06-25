class CreateAccountRoleStateTransitions < ActiveRecord::Migration[5.1]
  def change
    create_table :account_role_state_transitions do |table|
      table.uuid(:account_id, :null => false)
      table.uuid(:audit_actor_id, :null => false)
      table.string(:namespace)
      table.string(:event)
      table.string(:from, :null => false)
      table.string(:to, :null => false)
      table.timestamp(:created_at, :null => false)

      table.index(:account_id)
      table.foreign_key(:accounts, :column => :account_id)
    end
  end
end
