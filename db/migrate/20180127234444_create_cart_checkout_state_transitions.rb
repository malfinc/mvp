class CreateCartCheckoutStateTransitions < ActiveRecord::Migration[5.1]
  def change
    create_table :cart_checkout_state_transitions do |table|
      table.uuid :cart_id, null: false
      table.string :namespace, null: false
      table.string :event, null: false
      table.string :from, null: false
      table.string :to, null: false
      table.timestamp :created_at, null: false

      table.index :cart_id
      table.foreign_key :carts, column: :cart_id
    end
  end
end
