class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments, id: :uuid do |table|
      table.string :subtype, null: false
      table.text :source_id, null: false
      table.uuid :account_id, null: false
      table.uuid :cart_id, null: false
      table.integer :paid_cents, null: false
      table.string :paid_currency, null: false, default: "usd"
      table.integer :restitution_cents
      table.string :restitution_currency, default: "usd"
      table.citext :processing_state, null: false
      table.timestamps null: false

      table.index :subtype
      table.index :source_id
      table.index :account_id
      table.index :cart_id
      table.index :processing_state
      table.foreign_key :accounts, column: :account_id
      table.foreign_key :carts, column: :cart_id
    end

    safety_assured do
      add_null_constraint :payments, :restitution_cents, if: %("payments"."processing_state" = 'refunded')
      add_null_constraint :payments, :restitution_currency, if: %("payments"."processing_state" = 'refunded')
    end
  end
end
