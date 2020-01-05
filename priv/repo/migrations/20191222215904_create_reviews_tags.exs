defmodule Poutineer.Database.Repo.Migrations.CreateReviewsTags do
  use Ecto.Migration

  def change do
    create table(:reviews_tags, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :review_id, references(:reviews, on_delete: :nothing, type: :binary_id), null: false
      add :tag_id, references(:tags, on_delete: :nothing, type: :binary_id), null: false
    end

    create unique_index(:reviews_tags, [:review_id, :tag_id])
    create index(:reviews_tags, [:tag_id])
  end
end
