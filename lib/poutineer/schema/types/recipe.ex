defmodule Poutineer.Schema.Types.Recipe do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Poutineer.Repo

  object :recipe do
    field :id, non_null(:id)
    field :name, :string
    field :slug, non_null(:string)
    field :body, non_null(:string)
    field :cook_time, non_null(:integer)
    field :prep_time, non_null(:integer)
    field :ingredients, list_of(non_null(:string))
    field :instructions, list_of(non_null(:string))
    field :moderation_state, non_null(:string)
    field :inserted_at, non_null(:naive_datetime)
    field :updated_at, non_null(:naive_datetime)
    field :author_account, non_null(:account), resolve: assoc(:author_account)
    field :tags, list_of(non_null(:tag)), resolve: assoc(:tags)
  end
end
