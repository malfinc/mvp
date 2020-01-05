defmodule Poutineer.Database.Repo.Migrations.CreateRecipesTags do
  use Ecto.Migration

  def change do
    create table(:recipes_tags, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :recipe_id, references(:recipes, on_delete: :nothing, type: :binary_id), null: false
      add :tag_id, references(:tags, on_delete: :nothing, type: :binary_id), null: false
    end

    create unique_index(:recipes_tags, [:recipe_id, :tag_id])
    create index(:recipes_tags, [:tag_id])
  end
end
