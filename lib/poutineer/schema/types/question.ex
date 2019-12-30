defmodule Poutineer.Schema.Types.Question do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Poutineer.Repo

  enum :question_kind do
    value :pick_one
    value :pick_many
  end

  object :question do
    field :id, non_null(:id)
    field :body, non_null(:string)
    field :kind, non_null(:question_kind)
    field :inserted_at, non_null(:naive_datetime)
    field :updated_at, non_null(:naive_datetime)
    field :critiques, list_of(non_null(:critique)), resolve: assoc(:critiques)
    field :questions, list_of(non_null(:question)), resolve: assoc(:questions)
    field :foundational_question, :question, resolve: assoc(:foundational_question)
  end
end
