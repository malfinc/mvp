defmodule Poutineer.Resolvers.Recipes do
  alias Poutineer.Repo
  alias Poutineer.Models.Recipe

  def list(_parent, _arguments, _resolution) do
    {:ok, Repo.all(Recipe)}
  end

  def fetch(_parent, arguments, _resolution) do
    {:ok, Repo.get(Recipe, arguments[:id])}
  end

  def create(_parent, arguments, _resolution) do
    Recipe.changeset(%Recipe{}, arguments)
      |> case do
        %Ecto.Changeset{valid?: true} = changeset -> Repo.insert(changeset)
        %Ecto.Changeset{valid?: false} = changeset -> {:error, changeset}
      end
  end
end
