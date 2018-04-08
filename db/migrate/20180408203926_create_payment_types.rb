class CreatePaymentTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :payment_types do |table|
      table.string :name, null: false
      table.timestamps

      table.index :name, unique: true
    end
  end
end
