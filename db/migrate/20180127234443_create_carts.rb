class CreateCarts < ActiveRecord::Migration[5.1]
  def change
    create_table :carts, id: :uuid do |table|
      table.uuid :account_id, null: false
      table.string :checkout_state, null: false
      table.integer :total_cents
      table.string :total_currency
      table.integer :subtotal_cents
      table.string :subtotal_currency
      table.integer :discount_cents
      table.string :discount_currency
      table.integer :tax_cents
      table.string :tax_currency
      table.integer :shipping_cents
      table.string :shipping_currency
      table.timestamps null: false

      table.foreign_key :accounts, column: :account_id

      table.index :checkout_state
      table.index :account_id
    end

    safety_assured do
      add_null_constraint :carts, :total_cents, if: %("carts"."checkout_state" = 'purchased')
      add_null_constraint :carts, :total_currency, if: %("carts"."checkout_state" = 'purchased')
      add_null_constraint :carts, :subtotal_cents, if: %("carts"."checkout_state" = 'purchased')
      add_null_constraint :carts, :subtotal_currency, if: %("carts"."checkout_state" = 'purchased')
      add_null_constraint :carts, :discount_cents, if: %("carts"."checkout_state" = 'purchased')
      add_null_constraint :carts, :discount_currency, if: %("carts"."checkout_state" = 'purchased')
      add_null_constraint :carts, :tax_cents, if: %("carts"."checkout_state" = 'purchased')
      add_null_constraint :carts, :tax_currency, if: %("carts"."checkout_state" = 'purchased')
      add_null_constraint :carts, :shipping_cents, if: %("carts"."checkout_state" = 'purchased')
      add_null_constraint :carts, :shipping_currency, if: %("carts"."checkout_state" = 'purchased')
      add_unique_constraint :carts, :account_id, if: %("carts"."checkout_state" != 'purchased')
    end
  end
end
