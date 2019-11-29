defmodule Poutineer.Schema do
  use Absinthe.Schema
  import_types Poutineer.Schema.ContentTypes

  alias Poutineer.Resolvers

  query do
    @desc "Get all accounts"
    field :accounts, list_of(:account) do
      resolve &Resolvers.Content.list_accounts/3
    end
  end
end
