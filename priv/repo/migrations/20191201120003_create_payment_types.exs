defmodule Poutineer.Database.Repo.Migrations.CreatePaymentTypes do
  use Ecto.Migration

  def change do
    create table(:payment_types, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :text, null: false
      add :slug, :citext, null: false

      timestamps()
    end

    create unique_index(:payment_types, [:name])
    create unique_index(:payment_types, [:slug])
  end
end
