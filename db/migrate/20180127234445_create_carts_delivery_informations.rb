class CreateCartsDeliveryInformations < ActiveRecord::Migration[5.1]
  def change
    create_join_table :carts, :delivery_informations, id: :bigint do |table|
      table.uuid :delivery_information_id, null: false, index: true
      table.uuid :cart_id, null: false, index: true
      table.timestamps null: false

      table.index [:delivery_information_id, :cart_id], unique: true, name: "index_delivery_information_carts_on_join_columns"
      table.foreign_key :delivery_informations, column: :delivery_information_id
      table.foreign_key :carts, column: :cart_id
    end
  end
end
