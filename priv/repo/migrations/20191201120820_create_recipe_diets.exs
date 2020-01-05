defmodule Poutineer.Database.Repo.Migrations.CreateRecipeDiets do
  use Ecto.Migration

  def change do
    create table(:recipe_diets, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :recipe_id, references(:recipes, on_delete: :nothing, type: :binary_id), null: false
      add :diet_id, references(:diets, on_delete: :nothing, type: :binary_id), null: false
    end

    create unique_index(:recipe_diets, [:recipe_id, :diet_id])
    create index(:recipe_diets, [:diet_id])
  end
end
