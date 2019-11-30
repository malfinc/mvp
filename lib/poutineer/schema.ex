defmodule Poutineer.Schema do
  use Absinthe.Schema
  import_types Poutineer.Schema.Types

  alias Poutineer.Resolvers
  alias Crudry.Middlewares.TranslateErrors

  def middleware(middleware, _field, _object) do
    middleware ++ [TranslateErrors]
  end

  query do
    @desc "Get all accounts"
    field :accounts, list_of(:account) do
      resolve &Resolvers.Accounts.list_accounts/3
    end

    field :account, :account do
      arg :id, non_null(:id)
      resolve &Resolvers.Accounts.fetch_account/3
    end
  end

  mutation do
    field :create_account, :account do
      arg :email, non_null(:string)

      resolve &Resolvers.Accounts.create_account/3
    end
  end

  subscription do
    field :account_created, :account do
      arg :id, non_null(:id)

      # The topic function is used to determine what topic a given subscription
      # cares about based on its arguments.
      config fn args, _ ->
        {:ok, topic: args.id}
      end

      # This tells Absinthe to run any subscriptions with this field every time
      # the mutation happens. It also has a topic function used to find what
      # subscriptions care about this particular comment.
      trigger :create_account, topic: fn account ->
        account.id
      end
    end
  end
end
