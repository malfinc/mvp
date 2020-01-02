defmodule Poutineer.Schema.Resolvers.Sessions do
  def create(_parent, %{email: email, password: password}, _resolution) when is_bitstring(email) and is_bitstring(password) do
    # Find the account by email
    Poutineer.Repo.get_by(Poutioner.Models.Account, email: email)
      |> case do
        # Determine if the password is correct
        %Poutineer.Models.Account{} = account -> {Argon2.verify_pass(password, account.password_hash), account}
        nil -> {:error, "Login credentials were invalid or the account doesn't exist"}
      end
      |> case do
        # Only pass down the account id
        {true, %Poutineer.Models.Account{id: id}} -> {:ok, %{id: id}}
        {false, _} -> {:error, "Login credentials were invalid or the account doesn't exist"}
        {:error, message} -> {:error, message}
      end
  end
end
