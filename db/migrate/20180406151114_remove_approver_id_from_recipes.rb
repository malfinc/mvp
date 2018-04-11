class RemoveApproverIdFromRecipes < ActiveRecord::Migration[5.1]
  def change
    safety_assured do
      remove_column :recipes, :approver_id
    end
  end
end
