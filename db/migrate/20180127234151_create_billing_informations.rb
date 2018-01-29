class CreateBillingInformations < ActiveRecord::Migration[5.1]
  def change
    create_table :billing_informations, id: :uuid do |table|
      table.text :name, null: false
      table.text :address, null: false
      table.string :postal, null: false
      table.string :city, null: false
      table.string :state, null: false
      table.timestamps null: false
    end
  end
end
