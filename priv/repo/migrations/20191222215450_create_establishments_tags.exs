defmodule Poutineer.Database.Repo.Migrations.CreateEstablishmentsTags do
  use Ecto.Migration

  def change do
    create table(:establishments_tags, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :establishment_id, references(:establishments, on_delete: :nothing, type: :binary_id), null: false
      add :tag_id, references(:tags, on_delete: :nothing, type: :binary_id), null: false
    end

    create unique_index(:establishments_tags, [:establishment_id, :tag_id])
    create index(:establishments_tags, [:tag_id])
  end
end
