defmodule Poutineer.Schema.Types do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Poutineer.Repo

  import_types Absinthe.Type.Custom

  object :session do
    field :id, non_null(:string)
  end

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

  object :allergy do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :slug, non_null(:string)
    field :inserted_at, non_null(:naive_datetime)
    field :updated_at, non_null(:naive_datetime)
    field :menu_items, list_of(non_null(:menu_item)), resolve: assoc(:menu_items)
  end

  object :answer do
    field :id, non_null(:id)
    field :body, non_null(:string)
    field :inserted_at, non_null(:naive_datetime)
    field :updated_at, non_null(:naive_datetime)
    field :question, non_null(:question), resolve: assoc(:question)
    field :critiques, list_of(non_null(:critique)), resolve: assoc(:critiques)
  end

  object :critique do
    field :id, non_null(:id)
    field :guage, non_null(:integer)
    field :inserted_at, non_null(:naive_datetime)
    field :updated_at, non_null(:naive_datetime)
    field :author, non_null(:account), resolve: assoc(:author)
    field :review, non_null(:review), resolve: assoc(:review)
    field :answer, non_null(:answer), resolve: assoc(:answer)
    field :question, non_null(:question), resolve: assoc(:question)
  end

  object :diet do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :slug, non_null(:string)
    field :inserted_at, non_null(:naive_datetime)
    field :updated_at, non_null(:naive_datetime)
    field :menu_items, list_of(non_null(:menu_item)), resolve: assoc(:menu_items)
  end

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

  object :payment_type do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :slug, non_null(:string)
    field :inserted_at, non_null(:naive_datetime)
    field :updated_at, non_null(:naive_datetime)
    field :establishment, non_null(:establishment), resolve: assoc(:establishment)
  end

  enum :questiom_kind do
    value :pick_one
    value :pick_many
  end

  object :question do
    field :id, non_null(:id)
    field :body, non_null(:string)
    field :kind, non_null(:questiom_kind)
    field :inserted_at, non_null(:naive_datetime)
    field :updated_at, non_null(:naive_datetime)
    field :critiques, list_of(non_null(:critique)), resolve: assoc(:critiques)
  end

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
    field :author, non_null(:account), resolve: assoc(:author)
    field :tags, list_of(non_null(:tag)), resolve: assoc(:tags)
  end

  object :review do
    field :id, non_null(:id)
    field :inserted_at, non_null(:naive_datetime)
    field :updated_at, non_null(:naive_datetime)
    field :critiques, list_of(non_null(:critique)), resolve: assoc(:critiques)
    field :author, non_null(:account), resolve: assoc(:author)
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

  object :menu_item do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :slug, non_null(:string)
    field :body, non_null(:string)
    field :moderation_state, non_null(:string)
    field :inserted_at, non_null(:naive_datetime)
    field :updated_at, non_null(:naive_datetime)
    field :establishment, non_null(:establishment), resolve: assoc(:establishment)
    field :reviews, list_of(non_null(:review)), resolve: assoc(:reviews)
  end
end
