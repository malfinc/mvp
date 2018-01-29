class CreateCartItemPurchaseStateTransitions < ActiveRecord::Migration[5.1]
  def change
    create_table :cart_item_purchase_state_transitions do |table|
      table.uuid :cart_item_id, null: false
      table.string :namespace, null: false
      table.string :event, null: false
      table.string :from, null: false
      table.string :to, null: false
      table.timestamp :created_at, null: false

      table.index :cart_item_id
      table.foreign_key :cart_items, column: :cart_item_id
    end
  end
end
