defmodule Poutineer.Repo.Migrations.CreateAllergies do
  use Ecto.Migration

  def change do
    create table(:allergies, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :text, null: false

      timestamps()
    end

    create unique_index(:allergies, [:name])
  end
end
