defmodule Poutineer.Resolvers.Recipes do
  alias Poutineer.Repo
  alias Poutineer.Models.Recipe

  def list(_parent, _arguments, _resolution) do
    {:ok, Repo.all(Recipe)}
  end

  def fetch(_parent, arguments, _resolution) do
    {:ok, Repo.get(Recipe, arguments[:id])}
  end

  # def create(_parent, arguments, _resolution) do
  #   password = :crypto.strong_rand_bytes(24)
  #     |> Base.encode32(case: :upper)
  #     |> binary_part(0, 24)
  #
  #   Recipe.changeset(%Recipe{}, Map.merge(%{password: password, confirm_password: password}, arguments))
  #     |> case do
  #       %Ecto.Changeset{valid?: true} = changeset -> Repo.insert(changeset)
  #       %Ecto.Changeset{valid?: false} = changeset -> {:error, changeset}
  #     end
  # end
end
