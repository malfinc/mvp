class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table(:accounts, :id => :uuid) do |table|
      table.text(:name)
      table.citext(:email)
      table.citext(:username)
      table.citext(:onboarding_state, :null => false)
      table.citext(:role_state, :null => false)
      table.text(:encrypted_password, :null => false)
      table.text(:authentication_secret, :null => false)
      table.text(:reset_password_token)
      table.datetime(:reset_password_sent_at)
      table.datetime(:remember_created_at)
      table.text(:confirmation_token)
      table.datetime(:confirmed_at)
      table.datetime(:confirmation_sent_at)
      table.text(:unconfirmed_email)
      table.integer(:failed_attempts, :default => 0, :null => false)
      table.text(:unlock_token)
      table.datetime(:locked_at)
      table.timestamps(:null => false)

      table.index(:email)
      table.index(:username)
      table.index(:onboarding_state)
      table.index(:role_state)
      table.index(:confirmation_token, :unique => true)
      table.index(:unlock_token, :unique => true)
      table.index(:authentication_secret, :unique => true)
    end

    safety_assured do
      add_null_constraint(:accounts, :name, :if => %("accounts"."onboarding_state" = 'completed'))
      add_unique_constraint(:accounts, :email)
      add_unique_constraint(:accounts, :username)
    end
  end
end
