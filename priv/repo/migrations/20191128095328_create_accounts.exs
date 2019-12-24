defmodule Poutineer.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :email, :citext, null: false
      add :unconfirmed_email, :citext
      add :username, :citext
      add :name, :text
      add :onboarding_state, :citext, null: false, default: "converted"
      add :role_state, :citext, null: false, default: "user"
      add :password_hash, :string

      timestamps()
    end

    create unique_index(:accounts, [:email])
  end
end
