class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments, id: :uuid do |table|
      table.string :subtype, null: false
      table.text :service_eid, null: false
      table.uuid :account_id, null: false
      table.timestamps null: false

      table.index :subtype
      table.index :service_eid
      table.index :account_id
      table.foreign_key :accounts, column: :account_id
    end
  end
end
