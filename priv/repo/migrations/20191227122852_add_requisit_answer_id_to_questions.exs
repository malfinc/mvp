defmodule Poutineer.Database.Repo.Migrations.AddRequisitAnswerIdToQuestions do
  use Ecto.Migration

  def change do
    alter table(:questions) do
      add :requisit_answer_id, references(:answers, on_delete: :nothing, type: :binary_id)
    end
  end
end
