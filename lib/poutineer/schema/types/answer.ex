defmodule Poutineer.Schema.Types.Answer do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Poutineer.Repo

  object :answer do
    field :id, non_null(:id)
    field :body, non_null(:string)
    field :inserted_at, non_null(:naive_datetime)
    field :updated_at, non_null(:naive_datetime)
    field :question, non_null(:question), resolve: assoc(:question)
    field :critiques, list_of(non_null(:critique)), resolve: assoc(:critiques)
  end
end
