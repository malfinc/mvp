defmodule Poutineer.Schema.Resolvers.Recipes do
  def list(_parent, _arguments, _resolution) do
    {:ok, Poutineer.Repo.all(Poutineer.Models..Recipe)}
  end

  def fetch(_parent, %{id: id}, _resolution) when not is_nil(id) do
    {:ok, Poutineer.Repo.get(Poutineer.Models.Recipe, id)}
  end

  def create(_parent, arguments, resolution) do
    default_attributes = %{author_account_id: resolution.context.current_account.id}
    attributes = Map.merge(arguments, default_attributes)

    %Recipe{}
      |> Recipe.changeset(attributes)
      |> case do
        %Ecto.Changeset{valid?: true} = changeset -> Repo.insert(changeset)
        %Ecto.Changeset{valid?: false} = changeset -> {:error, changeset}
      end
  end
end
