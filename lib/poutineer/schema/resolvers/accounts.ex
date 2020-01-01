defmodule Poutineer.Schema.Resolvers.Accounts do
  def list(_parent, _arguments, _resolution) do
    {:ok, Poutineer.Repo.all(Poutineer.Models..Account)}
  end

  def fetch(_parent, %{id: id}, _resolution) when not is_nil(id) do
    {:ok, Poutineer.Repo.get(Poutineer.Models.Account, id)}
  end

  def create(_parent, arguments, _resolution) do
    default_attributes = %{
      username: List.first(String.split(arguments[:email], "@")),
      password: arguments[:password] || (:crypto.strong_rand_bytes(24) |> Base.encode32(case: :upper) |> binary_part(0, 24))
    }
    attributes = Map.merge(default_attributes, arguments)

    %Poutineer.Models.Account{}
      |> Poutineer.Models.Account.changeset(attributes)
      |> case do
        %Ecto.Changeset{valid?: true} = changeset -> Poutineer.Repo.insert(changeset)
        %Ecto.Changeset{valid?: false} = changeset -> {:error, changeset}
      end
  end
end
