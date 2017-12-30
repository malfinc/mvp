class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts, id: :uuid do |table|
      table.string :email, null: false
      table.string :login, null: false
      table.string :encrypted_password, null: false
      table.string :reset_password_token
      table.datetime :reset_password_sent_at
      table.datetime :remember_created_at
      table.string :confirmation_token
      table.datetime :confirmed_at
      table.datetime :confirmation_sent_at
      table.string :unconfirmed_email
      table.integer :failed_attempts, default: 0, null: false
      table.string :unlock_token
      table.datetime :locked_at
      table.timestamps null: false

      table.index :email, unique: true
      table.index :login, unique: true
      table.index :confirmation_token, unique: true
      table.index :unlock_token, unique: true
    end
  end
end
