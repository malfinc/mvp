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
  end

  object :review do
    field :id, :id
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime
    field :critiques, list_of(:critique)
    field :author, :account
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

  object :payment_type do
    field :id, :id
    field :name, :string
  end

  object :diet do
    field :id, :id
    field :name, :string
  end

  object :allergy do
    field :id, :id
    field :name, :string
  end

  object :question do
    field :body, :string
    field :kind, :string
    field :critiques, list_of(:critique)
  end

  object :answers do
    field :id, :id
    field :body, :string
    field :question, :question
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime
    field :critiques, list_of(:critique)
  end

  object :critiques do
    field :id, :id
    field :guage, :integer
    field :author, :author
    field :review, :review
    field :answer, :answer
    field :question, :question
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime
  end
end
