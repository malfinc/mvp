defmodule Poutineer.Graphql.Types.Tag do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Poutineer.Database.Repo

  enum :taggable_types do
    value :establishment, description: "Referencing the establishment data type"
    value :menu_item, description: "Referencing the menu item data type"
    value :recipe, description: "Referencing the recipe data type"
    value :review, description: "Referencing the review data type"
  end

  union :taggable do
    description "A thing that can be tagged"

    types [:establishment, :menu_item, :recipe, :review]
    resolve_type fn
      %Poutineer.Models.Establishment{}, _ -> :establishment
      %Poutineer.Models.MenuItem{}, _ -> :menu_item
      %Poutineer.Models.Recipe{}, _ -> :recipe
      %Poutineer.Models.Review{}, _ -> :review
    end
  end

  object :tag do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :slug, non_null(:string)
    field :inserted_at, non_null(:naive_datetime)
    field :updated_at, non_null(:naive_datetime)
    field :taggables, list_of(non_null(:taggable))
    field :establishments, list_of(non_null(:establishment)), resolve: assoc(:establishments)
    field :menu_items, list_of(non_null(:menu_item)), resolve: assoc(:menu_items)
    field :recipes, list_of(non_null(:recipe)), resolve: assoc(:recipes)
    field :reviews, list_of(non_null(:review)), resolve: assoc(:reviews)
  end
end
