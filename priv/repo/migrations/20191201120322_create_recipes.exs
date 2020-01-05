defmodule Poutineer.Database.Repo.Migrations.CreateRecipe do
  use Ecto.Migration

  def change do
    create table(:recipes, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :text, null: false
      add :slug, :citext, null: false
      add :body, :text, null: false
      add :moderation_state, :citext, null: false
      add :ingredients, {:array, :text}, null: false
      add :instructions, {:array, :text}, null: false
      add :cook_time, :integer, null: false
      add :prep_time, :integer, null: false
      add :author_account_id, references(:accounts, on_delete: :nothing, type: :binary_id), null: false

      timestamps()
    end

    create unique_index(:recipes, [:slug])
    create index(:recipes, [:author_account_id])
  end
end
