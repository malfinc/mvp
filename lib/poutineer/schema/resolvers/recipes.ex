defmodule Poutineer.Schema.Resolvers.Recipes do
  alias Poutineer.Repo
  alias Poutineer.Models.Recipe

  def list(_parent, _arguments, _resolution) do
    {:ok, Repo.all(Recipe)}
  end

  def fetch(_parent, arguments, _resolution) do
    {:ok, Repo.get(Recipe, arguments[:id])}
  end

  def create(_parent, arguments, resolution) do
    default_attributes = %{author_id: resolution.context.current_account.id}
    attributes = Map.merge(arguments, default_attributes)

    %Recipe{}
      |> Recipe.changeset(attributes)
      |> case do
        %Ecto.Changeset{valid?: true} = changeset -> Repo.insert(changeset)
        %Ecto.Changeset{valid?: false} = changeset -> {:error, changeset}
      end
  end
end
