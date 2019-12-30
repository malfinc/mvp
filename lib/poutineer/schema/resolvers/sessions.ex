defmodule Poutineer.Schema.Resolvers.Sessions do
  alias Poutineer.Repo
  alias Poutineer.Models.Account

  def create(_parent, arguments, _resolution) do
    %{email: email, password: password} = arguments

    # Find the account by email
    Repo.get_by(Account, email: email)
      |> case do
        # Determine if the password is correct
        %Poutineer.Models.Account{} = account -> {Argon2.verify_pass(password, account.password_hash), account}
        nil -> {:error, "Login credentials were invalid or the account doesn't exist"}
      end
      |> case do
        # Only pass down the account id
        {true, account} -> {:ok, %{id: account.id}}
        {false, _} -> {:error, "Login credentials were invalid or the account doesn't exist"}
        {:error, message} -> {:error, message}
      end
  end
end
