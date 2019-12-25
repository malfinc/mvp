defmodule Poutineer.Schema.Resolvers.Sessions do
  alias Poutineer.Repo
  alias Poutineer.Models.Account
  import Ecto.Query, only: [from: 2]

  # 1. Handle if email returns no accounts
  # 2. Handle if password doesn't match
  # 3. Handle if locked(?)
  # 4. Handle if all good
  def create(_parent, arguments, _resolution) do
    %{email: email, password: password} = arguments

    account = Repo.one!(
      from(account in Account, where: account.email == ^email)
    )

    password_verified = if account do
      Argon2.verify_pass(password, account.password_hash)
    end

    if account && password_verified do
      {:ok, %{id: account.id}}
    else
      {:error, "Login credentials were invalid or the account doesn't exist"}
    end
  end
end
# Plug.Conn.put_session(connection, :session_id, id)
