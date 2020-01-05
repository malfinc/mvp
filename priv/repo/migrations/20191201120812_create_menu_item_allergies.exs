defmodule Poutineer.Database.Repo.Migrations.CreateMenuItemAllergies do
  use Ecto.Migration

  def change do
    create table(:menu_item_allergies, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :allergy_id, references(:allergies, on_delete: :nothing, type: :binary_id), null: false
      add :menu_item_id, references(:menu_items, on_delete: :nothing, type: :binary_id), null: false
    end

    create unique_index(:menu_item_allergies, [:allergy_id, :menu_item_id])
    create index(:menu_item_allergies, [:menu_item_id])
  end
end
