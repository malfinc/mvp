defmodule Poutineer.Resolvers.Diets do
  alias Poutineer.Repo
  alias Poutineer.Models.Diet

  def list(_parent, _arguments, _resolution) do
    {:ok, Repo.all(Diet)}
  end

  def fetch(_parent, arguments, _resolution) do
    {:ok, Repo.get(Diet, arguments[:id])}
  end

  # def create(_parent, arguments, _resolution) do
  #   password = :crypto.strong_rand_bytes(24)
  #     |> Base.encode32(case: :upper)
  #     |> binary_part(0, 24)
  #
  #   Diet.changeset(%Diet{}, Map.merge(%{password: password, confirm_password: password}, arguments))
  #     |> case do
  #       %Ecto.Changeset{valid?: true} = changeset -> Repo.insert(changeset)
  #       %Ecto.Changeset{valid?: false} = changeset -> {:error, changeset}
  #     end
  # end
end
