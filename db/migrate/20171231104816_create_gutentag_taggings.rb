class CreateGutentagTaggings < ActiveRecord::Migration[5.2]
  def change
    create_table(:gutentag_taggings) do |table|
      table.belongs_to(:tag, :foreign_key => {:to_table => :gutentag_tags}, :null => false)
      table.belongs_to(:taggable, :polymorphic => true, :null => false)
      table.timestamps(:null => false)
    end
  end
end
