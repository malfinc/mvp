defmodule Poutineer.Database.Repo.Migrations.CreateReviews do
  use Ecto.Migration

  def change do
    create table(:reviews, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :body, :text, null: false
      add :moderation_state, :citext, null: false
      add :menu_item_id, references(:accounts, on_delete: :nothing, type: :binary_id), null: false
      add :author_account_id, references(:accounts, on_delete: :nothing, type: :binary_id), null: false

      timestamps()
    end

    create index(:reviews, [:author_account_id])
  end
end
