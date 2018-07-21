class CreateGutentagTags < ActiveRecord::Migration[5.1]
  def change
    create_table(:gutentag_tags, :id => :uuid) do |table|
      table.citext(:name, :null => false)
      table.bigint(:taggings_count, :null => false, :default => 0)
      table.timestamps(:null => false)

      table.index(:created_at)
      table.index(:updated_at)
      table.index(:name, :unique => true)
    end
  end
end
