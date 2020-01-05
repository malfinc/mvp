defmodule Poutineer.Graphql.Types.PaymentType do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Poutineer.Database.Repo

  object :payment_type do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :slug, non_null(:string)
    field :inserted_at, non_null(:naive_datetime)
    field :updated_at, non_null(:naive_datetime)
    field :establishment, non_null(:establishment), resolve: assoc(:establishment)
  end
end
