class CreatePaymentPurchaseStateTransitions < ActiveRecord::Migration[5.1]
  def change
    create_table :payment_purchase_state_transitions do |table|
      table.uuid :payment_id, null: false
      table.string :namespace, null: false
      table.string :event, null: false
      table.string :from, null: false
      table.string :to, null: false
      table.timestamp :created_at, null: false

      table.index :payment_id
      table.foreign_key :payments, column: :payment_id
    end
  end
end
