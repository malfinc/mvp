class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments, id: :uuid do |table|
      table.string :type, null: false
      table.text :external_id, null: false
      table.timestamps null: false

      table.index :type
      table.index :external_id, unique: true
    end
  end
end
