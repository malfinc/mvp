defmodule Poutineer.Database.Repo.Migrations.CreateMenuItemsTags do
  use Ecto.Migration

  def change do
    create table(:menu_items_tags, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :menu_item_id, references(:menu_items, on_delete: :nothing, type: :binary_id), null: false
      add :tag_id, references(:tags, on_delete: :nothing, type: :binary_id), null: false
    end

    create unique_index(:menu_items_tags, [:menu_item_id, :tag_id])
    create index(:menu_items_tags, [:tag_id])
  end
end
