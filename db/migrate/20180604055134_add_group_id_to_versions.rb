class AddGroupIdToVersions < ActiveRecord::Migration[5.1]
  def change
    add_column(:versions, :group_id, :text)
    PaperTrail::Version.update_all(:group_id => SecureRandom.uuid)
    change_column_null(:versions, :group_id, false)
  end
end
