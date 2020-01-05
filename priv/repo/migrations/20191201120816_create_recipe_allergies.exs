defmodule Poutineer.Database.Repo.Migrations.CreateRecipeAllergies do
  use Ecto.Migration

  def change do
    create table(:recipe_allergies, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :allergy_id, references(:allergies, on_delete: :nothing, type: :binary_id), null: false
      add :recipe_id, references(:recipes, on_delete: :nothing, type: :binary_id), null: false
    end

    create unique_index(:recipe_allergies, [:allergy_id, :recipe_id])
    create index(:recipe_allergies, [:recipe_id])
  end
end
