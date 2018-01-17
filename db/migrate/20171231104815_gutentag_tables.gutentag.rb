class GutentagTables < ActiveRecord::Migration[5.1]
  def change
    create_table :gutentag_tags, id: :uuid do |table|
      table.citext :name, null: false
      table.integer :taggings_count, null: false, default: 0
      table.timestamps null: false

      table.index :created_at
      table.index :updated_at
      table.index :name, unique: true
    end

    create_table :gutentag_taggings do |table|
      table.uuid :tag_id, null: false
      table.uuid :taggable_id, null: false
      table.string :taggable_type, null: false
      table.timestamps null: false

      table.index :tag_id
      table.index [:taggable_id, :taggable_type]
      table.index [:tag_id, :taggable_id, :taggable_type], unique: true, name: "index_guten_taggings_on_unique_tagging"

      table.foreign_key :gutentag_tags, column: :tag_id
    end
  end
end
