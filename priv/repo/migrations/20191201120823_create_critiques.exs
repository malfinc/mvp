defmodule Poutineer.Database.Repo.Migrations.CreateCritiques do
  use Ecto.Migration

  def change do
    create table(:critiques, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :guage, :integer, null: false
      add :author_account_id, references(:accounts, on_delete: :nothing, type: :binary_id), null: false
      add :review_id, references(:reviews, on_delete: :nothing, type: :binary_id), null: false
      add :answer_id, references(:answers, on_delete: :nothing, type: :binary_id), null: false
      add :question_id, references(:questions, on_delete: :nothing, type: :binary_id), null: false

      timestamps()
    end

    create index(:critiques, [:author_account_id, :review_id])
    create index(:critiques, [:review_id])
    create index(:critiques, [:author_account_id, :answer_id])
    create index(:critiques, [:answer_id])
    create index(:critiques, [:author_account_id, :question_id])
    create unique_index(:critiques, [:question_id, :answer_id, :author_account_id, :review_id])
  end
end
