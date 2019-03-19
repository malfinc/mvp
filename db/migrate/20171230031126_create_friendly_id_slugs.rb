class CreateFriendlyIdSlugs < ActiveRecord::Migration[5.2]
  def change
    create_table(:friendly_id_slugs) do |table|
      table.citext(:slug, :null => false)
      table.belongs_to(:sluggable, :polymorphic => true, :null => false)
      table.text(:scope)
      table.datetime(:created_at, :null => false)

      table.index([:slug, :sluggable_type], :length => {:slug => 140, :sluggable_type => 50})
      table.index([:slug, :sluggable_type, :scope], :length => {:slug => 70, :sluggable_type => 50, :scope => 70}, :unique => true)
    end
  end
end
