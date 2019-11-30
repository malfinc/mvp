defmodule Poutineer.Schema.Types do
  use Absinthe.Schema.Notation

  object :account do
    field :id, :id
    field :email, :string
  end
end
