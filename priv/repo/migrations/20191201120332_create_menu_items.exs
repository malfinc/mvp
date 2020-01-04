defmodule Poutineer.Database.Repo.Migrations.CreateMenuItems do
  use Ecto.Migration

  def change do
    create table(:menu_items, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :text, null: false
      add :slug, :citext, null: false
      add :body, :text, null: false
      add :moderation_state, :citext, null: false
      add :establishment_id, references(:establishments, on_delete: :nothing, type: :binary_id), null: false

      timestamps()
    end

    create unique_index(:menu_items, [:slug])
    create index(:menu_items, [:establishment_id])
  end
end
