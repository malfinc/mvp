defmodule Poutineer.Schema.Resolvers.Accounts do
  alias Poutineer.Repo
  alias Poutineer.Models.Account

  def list(_parent, _arguments, _resolution) do
    {:ok, Repo.all(Account)}
  end

  def fetch(_parent, arguments, _resolution) do
    {:ok, Repo.get(Account, arguments[:id])}
  end

  def create(_parent, arguments, _resolution) do
    default_attributes = %{
      username: List.first(String.split(arguments[:email], "@")),
      password: arguments[:password] || (:crypto.strong_rand_bytes(24) |> Base.encode32(case: :upper) |> binary_part(0, 24))
    }
    attributes = Map.merge(default_attributes, arguments)
    changeset = Account.changeset(%Account{}, attributes)

    case changeset do
      %Ecto.Changeset{valid?: true} -> Repo.insert(changeset)
      %Ecto.Changeset{valid?: false} -> {:error, changeset}
    end
  end
end
