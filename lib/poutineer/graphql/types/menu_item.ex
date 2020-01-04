defmodule Poutineer.Graphql.Types.MenuItem do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Poutineer.Repo

  object :menu_item do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :slug, non_null(:string)
    field :body, non_null(:string)
    field :moderation_state, non_null(:string)
    field :inserted_at, non_null(:naive_datetime)
    field :updated_at, non_null(:naive_datetime)
    field :allergies, list_of(non_null(:allergy)), resolve: assoc(:allergies)
    field :diets, list_of(non_null(:diet)), resolve: assoc(:diets)
    field :establishment, non_null(:establishment), resolve: assoc(:establishment)
    field :tags, list_of(non_null(:tag)), resolve: assoc(:tags)
  end
end
