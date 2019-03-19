class CreatePaymentTypes < ActiveRecord::Migration[5.2]
  def change
    create_table(:payment_types) do |table|
      table.text(:name, :null => false)
      table.timestamps

      table.index(:name, :unique => true)
    end
  end
end
