defmodule Poutineer.Schema.Types do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Poutineer.Repo

  import_types Absinthe.Type.Custom

  object :account do
    field :id, :id
    field :email, :string
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime
    field :critiques, list_of(:critique), resolve: assoc(:critiques)
    field :reviews, list_of(:review), resolve: assoc(:reviews)
    field :recipes, list_of(:recipe), resolve: assoc(:recipes)
  end

  object :allergy do
    field :id, :id
    field :name, :string
    field :slug, :string
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime
    field :menu_items, list_of(:menu_item), resolve: assoc(:menu_items)
  end

  object :answer do
    field :id, :id
    field :body, :string
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime
    field :question, :question, resolve: assoc(:question)
    field :critiques, list_of(:critique), resolve: assoc(:critiques)
  end

  object :critique do
    field :id, :id
    field :guage, :integer
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime
    field :author, :account, resolve: assoc(:author)
    field :review, :review, resolve: assoc(:review)
    field :answer, :answer, resolve: assoc(:answer)
    field :question, :question, resolve: assoc(:question)
  end

  object :diet do
    field :id, :id
    field :name, :string
    field :slug, :string
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime
    field :menu_items, list_of(:menu_item), resolve: assoc(:menu_items)
  end

  object :establishment do
    field :id, :id
    field :name, :string
    field :slug, :string
    field :moderation_state, :string
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime
    field :menu_items, list_of(:menu_item), resolve: assoc(:menu_items)
    field :payment_types, list_of(:payment_type), resolve: assoc(:payment_types)
    field :reviews, list_of(:review), resolve: assoc(:reviews)
    field :tags, list_of(:tag), resolve: assoc(:tags)
  end

  object :menu_item do
    field :id, :id
    field :name, :string
    field :slug, :string
    field :body, :string
    field :moderation_state, :string
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime
    field :allergies, list_of(:allergy), resolve: assoc(:allergies)
    field :diets, list_of(:diet), resolve: assoc(:diets)
    field :establishment, :establishment, resolve: assoc(:establishment)
    field :tags, list_of(:tag), resolve: assoc(:tags)
  end

  object :payment_type do
    field :id, :id
    field :name, :string
    field :slug, :string
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime
    field :establishment, :establishment, resolve: assoc(:establishment)
  end

  object :question do
    field :id, :id
    field :body, :string
    field :kind, :string
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime
    field :critiques, list_of(:critique), resolve: assoc(:critiques)
  end

  object :recipe do
    field :id, :id
    field :name, :string
    field :slug, :string
    field :body, :string
    field :cook_time, :integer
    field :ingredients, list_of(:string)
    field :instructions, list_of(:string)
    field :moderation_state, :string
    field :prep_time, :integer
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime
    field :author, :account, resolve: assoc(:author)
    field :tags, list_of(:tag), resolve: assoc(:tags)
  end

  object :review do
    field :id, :id
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime
    field :critiques, list_of(:critique), resolve: assoc(:critiques)
    field :author, :account, resolve: assoc(:author)
  end

  object :tag do
    field :id, :id
    field :name, :string
    field :slug, :string
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime
    field :establishments, list_of(:establishment), resolve: assoc(:establishments)
    field :menu_items, list_of(:menu_item), resolve: assoc(:menu_items)
    field :recipes, list_of(:recipe), resolve: assoc(:recipes)
    field :reviews, list_of(:review), resolve: assoc(:reviews)
  end

  object :menu_item do
    field :id, :id
    field :name, :string
    field :slug, :string
    field :body, :string
    field :moderation_state, :string
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime
    field :establishment, :establishment, resolve: assoc(:establishment)
    field :reviews, list_of(:review), resolve: assoc(:reviews)
  end
end
