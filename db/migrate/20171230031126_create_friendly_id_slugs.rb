class CreateFriendlyIdSlugs < ActiveRecord::Migration[5.1]
  def change
    create_table(:friendly_id_slugs, :id => :bigserial) do |table|
      table.citext(:slug, :null => false)
      table.uuid(:sluggable_id, :null => false)
      table.text(:sluggable_type, :null => false)
      table.text(:scope)
      table.datetime(:created_at, :null => false)

      table.index([:sluggable_id, :sluggable_type])
      table.index([:slug, :sluggable_type], :length => {:slug => 140, :sluggable_type => 50})
      table.index([:slug, :sluggable_type, :scope], :length => {:slug => 70, :sluggable_type => 50, :scope => 70}, :unique => true)
    end
  end
end
