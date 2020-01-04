defmodule Poutineer.Database.Repo.Migrations.CreateMenuItemDiets do
  use Ecto.Migration

  def change do
    create table(:menu_item_diets, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :menu_item_id, references(:menu_items, on_delete: :nothing, type: :binary_id), null: false
      add :diet_id, references(:diets, on_delete: :nothing, type: :binary_id), null: false
    end

    create unique_index(:menu_item_diets, [:menu_item_id, :diet_id])
    create index(:menu_item_diets, [:diet_id])
  end
end
