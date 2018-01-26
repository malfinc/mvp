class CreateAccountStateTransitions < ActiveRecord::Migration[5.1]
  def change
    create_table :account_role_state_transitions, id: :uuid do |table|
      table.uuid :account_id, null: false
      table.string :namespace, null: false
      table.string :event, null: false
      table.string :from, null: false
      table.string :to, null: false
      table.timestamp :created_at, null: false

      table.index :account_id
      table.foreign_key :accounts, column: :account_id
    end
  end
end
