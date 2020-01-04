defmodule Poutineer.Database.Repo.Migrations.CreateDiets do
  use Ecto.Migration

  def change do
    create table(:diets, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :text, null: false
      add :slug, :citext, null: false

      timestamps()
    end

    create unique_index(:diets, [:name])
    create unique_index(:diets, [:slug])
  end
end
