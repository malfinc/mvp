class DropAccountOnboardingStateTransitions < ActiveRecord::Migration[5.1]
  def change
    drop_table :account_onboarding_state_transitions
  end
end
