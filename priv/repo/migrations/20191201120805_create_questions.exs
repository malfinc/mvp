defmodule Poutineer.Database.Repo.Migrations.CreateQuestions do
  use Ecto.Migration

  def change do
    create table(:questions, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :body, :text, null: false
      add :kind, :citext, null: false

      timestamps()
    end
  end
end
