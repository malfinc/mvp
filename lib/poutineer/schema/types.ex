defmodule Poutineer.Schema.Types do
  use Absinthe.Schema.Notation

  import_types Absinthe.Type.Custom

  object :account do
    field :id, :id
    field :email, :string
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime
    field :critiques, list_of(:critique)
    field :reviews, list_of(:review)
    field :recipes, list_of(:recipe)
  end

  object :allergy do
    field :id, :id
    field :name, :string
    field :slug, :string
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime
  end

  object :answer do
    field :id, :id
    field :body, :string
    field :question, :question
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime
    field :critiques, list_of(:critique)
  end

  object :critique do
    field :id, :id
    field :guage, :integer
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime
    field :author, :account
    field :review, :review
    field :answer, :answer
    field :question, :question
  end

  object :diet do
    field :id, :id
    field :name, :string
    field :slug, :string
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime
  end

  object :establishment do
    field :id, :id
    field :name, :string
    field :slug, :string
    field :moderation_state, :string
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime
    field :menu_items, list_of(:menu_item)
  end

  object :menu_item do
    field :id, :id
    field :name, :string
    field :slug, :string
    field :body, :string
    field :moderation_state, :string
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime
  end

  object :payment_type do
    field :id, :id
    field :name, :string
    field :slug, :string
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime
  end

  object :question do
    field :id, :id
    field :body, :string
    field :kind, :string
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime
    field :critiques, list_of(:critique)
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
    field :author, :account
    field :tags, :tag
  end

  object :review do
    field :id, :id
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime
    field :critiques, list_of(:critique)
    field :author, :account
  end

  object :tag do
    field :id, :id
    field :name, :string
    field :slug, :string
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime
  end

  object :menu_item do
    field :id, :id
    field :name, :string
    field :slug, :string
    field :body, :string
    field :moderation_state, :string
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime
  end
end
