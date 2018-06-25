class DropAccountRoleStateTransitions < ActiveRecord::Migration[5.1]
  def change
    drop_table(:account_role_state_transitions)
  end
end
