defmodule Poutineer.Schema.Types do
  use Absinthe.Schema.Notation

  import_types Absinthe.Type.Custom

  object :account do
    field :id, :id
    field :email, :string
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime
  end
  end
end
