defmodule Poutineer.Schema.Types.Critique do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Poutineer.Repo

  object :critique do
    field :id, non_null(:id)
    field :guage, non_null(:integer)
    field :inserted_at, non_null(:naive_datetime)
    field :updated_at, non_null(:naive_datetime)
    field :author_account, non_null(:account), resolve: assoc(:author_account)
    field :review, non_null(:review), resolve: assoc(:review)
    field :answer, non_null(:answer), resolve: assoc(:answer)
    field :question, non_null(:question), resolve: assoc(:question)
  end
end
