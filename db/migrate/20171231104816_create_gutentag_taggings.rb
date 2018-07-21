class CreateGutentagTaggings < ActiveRecord::Migration[5.1]
  def change
    create_table(:gutentag_taggings, :id => :bigserial) do |table|
      table.uuid(:tag_id, :null => false)
      table.uuid(:taggable_id, :null => false)
      table.text(:taggable_type, :null => false)
      table.timestamps(:null => false)

      table.index(:tag_id)
      table.index([:taggable_id, :taggable_type])
      table.index([:tag_id, :taggable_id, :taggable_type], :unique => true, :name => "index_guten_taggings_on_unique_tagging")

      table.foreign_key(:gutentag_tags, :column => :tag_id)
    end
  end
end
