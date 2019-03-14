class CreateAllergyMenuItems < ActiveRecord::Migration[5.1]
  def change
    create_join_table :allergies, :menu_items do |table|
      table.references(:allergy, :type => :bigint, :index => true, :foreign_key => true, :null => false)
      table.references(:menu_item, :type => :uuid, :index => true, :foreign_key => true, :null => false)

      table.index([:allergy_id, :menu_item_id], :unique => true)
    end
  end
end
