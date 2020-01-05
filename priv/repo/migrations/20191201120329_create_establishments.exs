defmodule Poutineer.Database.Repo.Migrations.CreateEstablishments do
  use Ecto.Migration

  def change do
    create table(:establishments, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :text, null: false
      add :slug, :citext, null: false
      add :google_place_id, :text, null: false
      add :google_place_data, :map
      add :moderation_state, :citext, null: false

      timestamps()
    end

    create unique_index(:establishments, [:slug])
    create unique_index(:establishments, [:google_place_id])
  end
end
