class CreateCarts < ActiveRecord::Migration[5.1]
  def change
    create_table(:carts, :id => :uuid) do |table|
      table.citext(:sale_state, :null => false, :default => "pending")
      table.timestamps(:null => false)
      table.uuid(:account_id, :null => false)

      table.index(:sale_state)
      table.index(:account_id)

      table.foreign_key(:accounts, :column => :account_id)
    end
  end
end
