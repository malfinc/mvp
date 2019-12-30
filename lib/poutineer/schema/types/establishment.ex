defmodule Poutineer.Schema.Types.Establishment do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Poutineer.Repo

  object :establishment do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :slug, non_null(:string)
    field :moderation_state, non_null(:string)
    field :inserted_at, non_null(:naive_datetime)
    field :updated_at, non_null(:naive_datetime)
    field :menu_items, list_of(non_null(:menu_item)), resolve: assoc(:menu_items)
    field :payment_types, list_of(non_null(:payment_type)), resolve: assoc(:payment_types)
    field :reviews, list_of(non_null(:review)), resolve: assoc(:reviews)
    field :tags, list_of(non_null(:tag)), resolve: assoc(:tags)
  end
end
