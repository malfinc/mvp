class CreateCartsShippingInformations < ActiveRecord::Migration[5.1]
  def change
    create_join_table :carts, :shipping_informations, id: :bigint do |table|
      table.uuid :shipping_information_id, null: false, index: true
      table.uuid :cart_id, null: false, index: true
      table.timestamps null: false

      table.index [:shipping_information_id, :cart_id], unique: true, name: "index_shipping_information_carts_on_join_columns"
      table.foreign_key :shipping_informations, column: :shipping_information_id
      table.foreign_key :carts, column: :cart_id
    end
  end
end
