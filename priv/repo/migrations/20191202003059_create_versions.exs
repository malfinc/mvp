defmodule Repo.Migrations.AddVersions do
  use Ecto.Migration

  def change do
    create table(:versions) do
      add :event, :citext, null: false
      add :item_type, :text, null: false
      add :item_id, :uuid
      add :item_changes, :map, null: false
      add :originator_id, references(:accounts, on_delete: :nothing, type: :binary_id), null: false
      add :origin, :text
      add :meta, :map
      add :inserted_at, :utc_datetime, null: false
    end

    create index(:versions, [:originator_id])
    create index(:versions, [:item_id, :item_type])
    create index(:versions, [:event])
    create index(:versions, [:item_type])
    create index(:versions, [:inserted_at])
  end
end
