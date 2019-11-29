defmodule Poutineer.Accounts.Account do
  use Ecto.Schema
  use Pow.Ecto.Schema

  schema "accounts" do
    pow_user_fields()

    timestamps()
  end
end
