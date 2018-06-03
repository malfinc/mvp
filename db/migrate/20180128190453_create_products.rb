class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products, id: :uuid do |table|
      table.text :name, null: false
      table.text :slug, null: false
      table.text :description, null: false
      table.jsonb :metadata, null: false, default: {}
      table.text :checksum, null: false
      table.integer :price_cents, null: false
      table.text :price_currency, null: false, default: "usd"
      table.text :visibility_state, null: false
      table.timestamps null: false

      table.index :slug, unique: true
      table.index :visibility_state
      table.index :checksum
    end
  end
end
