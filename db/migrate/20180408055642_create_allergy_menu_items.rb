class CreateAllergyMenuItems < ActiveRecord::Migration[5.2]
  def change
    create_join_table(:allergies, :menu_items) do |table|
      table.belongs_to(:allergy, :foreign_key => true, :null => false)
      table.belongs_to(:menu_item, :foreign_key => true, :null => false)

      table.index([:allergy_id, :menu_item_id], :unique => true)
    end
  end
end
