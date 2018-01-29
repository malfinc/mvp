class CreateCarts < ActiveRecord::Migration[5.1]
  def change
    create_table :carts, id: :uuid do |table|
      table.uuid :account_id, null: false
      table.uuid :billing_information_id
      table.uuid :shipping_information_id
      table.uuid :payment_id
      table.string :checkout_state, null: false
      table.timestamps null: false

      table.foreign_key :accounts, column: :account_id
      table.foreign_key :billing_informations, column: :billing_information_id
      table.foreign_key :shipping_informations, column: :shipping_information_id
      table.foreign_key :payments, column: :payment_id

      table.index :checkout_state
      table.index :account_id, unique: true
      table.index :billing_information_id
      table.index :shipping_information_id
      table.index :payment_id
    end
  end
end
