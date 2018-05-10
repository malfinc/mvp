class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products, id: :uuid do |table|
      table.string :name, null: false
      table.string :slug, null: false
      table.string :description, null: false
      table.jsonb :metadata, null: false, default: {}
      table.string :checksum, null: false
      table.integer :price_cents, null: false
      table.string :price_currency, null: false, default: "usd"
      table.string :visibility_state, null: false
      table.timestamps null: false

      table.index :slug, unique: true
      table.index :visibility_state
      table.index :checksum
    end
  end
end
