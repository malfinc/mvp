class CreateProductVisibilityStateTransitions < ActiveRecord::Migration[5.1]
  def change
    create_table :product_visibility_state_transitions do |table|
      table.uuid :product_id, null: false
      table.string :namespace, null: false
      table.string :event, null: false
      table.string :from, null: false
      table.string :to, null: false
      table.timestamp :created_at, null: false

      table.index :product_id
      table.foreign_key :products, column: :product_id
    end
  end
end
