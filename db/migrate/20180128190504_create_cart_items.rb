class CreateCartItems < ActiveRecord::Migration[5.1]
  def change
    create_table :cart_items, id: :uuid do |table|
      table.uuid :cart_id, null: false
      table.uuid :product_id, null: false
      table.integer :price_cents, null: false
      table.uuid :account_id, null: false
      table.string :purchase_state, null: false
      table.string :price_currency, null: false
      table.timestamps null: false

      table.index :cart_id
      table.index :product_id
      table.index :account_id
      table.index :purchase_state

      table.foreign_key :carts, column: :cart_id
      table.foreign_key :products, column: :product_id
      table.foreign_key :accounts, column: :account_id
    end
  end
end
