defmodule Poutineer.Schema.Types.Account do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Poutineer.Repo

  object :account do
    field :id, non_null(:id)
    field :email, non_null(:string)
    field :name, :string
    field :username, :string
    field :inserted_at, non_null(:naive_datetime)
    field :updated_at, non_null(:naive_datetime)
    field :critiques, list_of(non_null(:critique)), resolve: assoc(:critiques)
    field :reviews, list_of(non_null(:review)), resolve: assoc(:reviews)
    field :recipes, list_of(non_null(:recipe)), resolve: assoc(:recipes)
  end
end
