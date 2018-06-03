class CreateCarts < ActiveRecord::Migration[5.1]
  def change
    create_table :carts, id: :uuid do |table|
      table.uuid :account_id, null: false
      table.uuid :delivery_information_id
      table.uuid :billing_information_id
      table.text :checkout_state, null: false
      table.integer :total_cents
      table.text :total_currency, default: "usd"
      table.integer :subtotal_cents
      table.text :subtotal_currency, default: "usd"
      table.integer :discount_cents
      table.text :discount_currency, default: "usd"
      table.integer :tax_cents
      table.text :tax_currency, default: "usd"
      table.integer :shipping_cents
      table.text :shipping_currency, default: "usd"
      table.timestamps null: false

      table.foreign_key :accounts, column: :account_id
      table.foreign_key :delivery_informations, column: :delivery_information_id
      table.foreign_key :billing_informations, column: :billing_information_id

      table.index :checkout_state
      table.index :account_id
      table.index :delivery_information_id, where: %("carts"."delivery_information_id" IS NOT NULL)
      table.index :billing_information_id, where: %("carts"."billing_information_id" IS NOT NULL)
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
      add_null_constraint :carts, :delivery_information_id, if: %("carts"."checkout_state" = 'purchased')
      add_null_constraint :carts, :billing_information_id, if: %("carts"."checkout_state" = 'purchased')
      add_unique_constraint :carts, :account_id, if: %("carts"."checkout_state" != 'purchased')
    end
  end
end
