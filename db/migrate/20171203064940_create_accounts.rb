class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts, id: :uuid do |table|
      table.string :email, null: false, index: {unique: true}
      table.string :encrypted_password, null: false
      table.string :reset_password_token, index: {unique: true}
      table.datetime :reset_password_sent_at
      table.datetime :remember_created_at
      table.string :confirmation_token, index: {unique: true}
      table.datetime :confirmed_at
      table.datetime :confirmation_sent_at
      table.string :unconfirmed_email
      table.integer :failed_attempts, default: 0, null: false
      table.string :unlock_token, index: {unique: true}
      table.datetime :locked_at
      table.jsonb :metadata, null: false, default: {}
      table.timestamps null: false
    end
  end
end
