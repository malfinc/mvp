defmodule Poutineer.Schema.Types.Session do
  use Absinthe.Schema.Notation

  object :session do
    field :id, non_null(:string)
  end
end
